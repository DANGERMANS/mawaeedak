/**
 * goalsGateway.ts — Phase 16 Production Hardening
 * 
 * Unified data gateway for Goals.
 * - Supabase sync when user is logged in
 * - LocalStorage fallback for guests
 * 
 * Schema: supabase/migrations/20250612000002_create_services_tables.sql
 */

import { supabase, isSupabaseEnabled } from "../supabase";
import { isSupabaseMode } from "../dataSourceMode";

export type GoalType = "financial" | "non-financial";

export type Goal = {
  id: string;
  name: string;
  type: GoalType;
  targetAmount: number | null;
  requirements: string;
  currentProgress: number;
  deadline: string | null;
  createdAt: string;
  completedAt: string | null;
};

// Supabase DB row type
type GoalRow = {
  id: string;
  user_id: string;
  name: string;
  type: GoalType;
  target_amount: number | null;
  requirements: string | null;
  current_progress: number;
  deadline: string | null;
  completed_at: string | null;
  created_at: string;
};

const GOALS_STORAGE_KEY = "mawaeedak_goals_v1";

function generateId(): string {
  return `goal_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
}

// LocalStorage helpers
function loadLocalGoals(): Goal[] {
  try {
    const stored = localStorage.getItem(GOALS_STORAGE_KEY);
    if (stored) return JSON.parse(stored);
  } catch { /* ignore */ }
  return [];
}

function saveLocalGoals(goals: Goal[]): void {
  try {
    localStorage.setItem(GOALS_STORAGE_KEY, JSON.stringify(goals));
  } catch { /* ignore */ }
}

// Convert Supabase row to Goal
function toGoal(row: GoalRow): Goal {
  return {
    id: row.id,
    name: row.name,
    type: row.type,
    targetAmount: row.target_amount,
    requirements: row.requirements || "",
    currentProgress: row.current_progress || 0,
    deadline: row.deadline || null,
    createdAt: row.created_at,
    completedAt: row.completed_at || null,
  };
}

// Convert Goal to Supabase row format
function toGoalRow(goal: Goal, userId: string): Record<string, unknown> {
  return {
    id: goal.id.startsWith("goal_") ? undefined : goal.id,
    user_id: userId,
    name: goal.name,
    type: goal.type,
    target_amount: goal.targetAmount,
    requirements: goal.requirements || null,
    current_progress: goal.currentProgress,
    deadline: goal.deadline || null,
    completed_at: goal.completedAt || null,
  };
}

export interface GoalsGateway {
  // State
  goals: Goal[];
  isLoading: boolean;
  isError: boolean;
  isSynced: boolean; // true = Supabase, false = localStorage
  
  // Operations
  load(): Promise<void>;
  add(goal: Omit<Goal, "id" | "createdAt" | "completedAt">): Promise<Goal | null>;
  update(goal: Goal): Promise<boolean>;
  delete(id: string): Promise<boolean>;
  complete(id: string): Promise<boolean>;
  updateProgress(id: string, progress: number): Promise<boolean>;
}

export function createGoalsGateway(): GoalsGateway {
  let goals: Goal[] = [];
  let isLoading = true;
  let isError = false;
  let isSynced = false;
  let currentUserId: string | null = null;
  
  const listeners: Set<() => void> = new Set();
  
  function notify() {
    listeners.forEach(fn => fn());
  }
  
  async function load(): Promise<void> {
    isLoading = true;
    isError = false;
    notify();
    
    try {
      if (isSupabaseEnabled && supabase && isSupabaseMode) {
        const { data: sessionData } = await supabase.auth.getSession();
        const userId = sessionData?.session?.user?.id;
        
        if (userId) {
          currentUserId = userId;
          const { data, error } = await supabase
            .from("goals")
            .select("*")
            .eq("user_id", userId)
            .order("created_at", { ascending: false });
          
          if (error) throw error;
          
          goals = (data || []).map(toGoal);
          isSynced = true;
          isLoading = false;
          notify();
          return;
        }
      }
      
      // Fallback to localStorage
      currentUserId = null;
      goals = loadLocalGoals();
      isSynced = false;
    } catch (error) {
      console.error("[GoalsGateway] Load error:", error);
      goals = loadLocalGoals();
      isSynced = false;
      isError = true;
    }
    
    isLoading = false;
    notify();
  }
  
  async function add(goalData: Omit<Goal, "id" | "createdAt" | "completedAt">): Promise<Goal | null> {
    const newGoal: Goal = {
      ...goalData,
      id: generateId(),
      createdAt: new Date().toISOString(),
      completedAt: null,
    };
    
    try {
      if (isSynced && currentUserId && supabase) {
        const row = toGoalRow(newGoal, currentUserId);
        const { error } = await supabase.from("goals").insert(row);
        
        if (error) throw error;
      }
      
      goals = [newGoal, ...goals];
      saveLocalGoals(goals);
      notify();
      return newGoal;
    } catch (error) {
      console.error("[GoalsGateway] Add error:", error);
      // Save locally anyway
      goals = [newGoal, ...goals];
      saveLocalGoals(goals);
      notify();
      return newGoal;
    }
  }
  
  async function update(goal: Goal): Promise<boolean> {
    try {
      if (isSynced && supabase) {
        const { error } = await supabase
          .from("goals")
          .update({
            name: goal.name,
            type: goal.type,
            target_amount: goal.targetAmount,
            requirements: goal.requirements,
            current_progress: goal.currentProgress,
            deadline: goal.deadline,
          })
          .eq("id", goal.id);
        
        if (error) throw error;
      }
      
      goals = goals.map(g => g.id === goal.id ? goal : g);
      saveLocalGoals(goals);
      notify();
      return true;
    } catch (error) {
      console.error("[GoalsGateway] Update error:", error);
      goals = goals.map(g => g.id === goal.id ? goal : g);
      saveLocalGoals(goals);
      notify();
      return false;
    }
  }
  
  async function deleteGoal(id: string): Promise<boolean> {
    try {
      if (isSynced && supabase) {
        const { error } = await supabase.from("goals").delete().eq("id", id);
        if (error) throw error;
      }
      
      goals = goals.filter(g => g.id !== id);
      saveLocalGoals(goals);
      notify();
      return true;
    } catch (error) {
      console.error("[GoalsGateway] Delete error:", error);
      goals = goals.filter(g => g.id !== id);
      saveLocalGoals(goals);
      notify();
      return false;
    }
  }
  
  async function complete(id: string): Promise<boolean> {
    const completedAt = new Date().toISOString();
    
    try {
      if (isSynced && supabase) {
        const { error } = await supabase
          .from("goals")
          .update({ completed_at: completedAt })
          .eq("id", id);
        
        if (error) throw error;
      }
      
      goals = goals.map(g => g.id === id ? { ...g, completedAt } : g);
      saveLocalGoals(goals);
      notify();
      return true;
    } catch (error) {
      console.error("[GoalsGateway] Complete error:", error);
      goals = goals.map(g => g.id === id ? { ...g, completedAt } : g);
      saveLocalGoals(goals);
      notify();
      return false;
    }
  }
  
  async function updateProgress(id: string, progress: number): Promise<boolean> {
    try {
      if (isSynced && supabase) {
        const { error } = await supabase
          .from("goals")
          .update({ current_progress: progress })
          .eq("id", id);
        
        if (error) throw error;
      }
      
      goals = goals.map(g => g.id === id ? { ...g, currentProgress: progress } : g);
      saveLocalGoals(goals);
      notify();
      return true;
    } catch (error) {
      console.error("[GoalsGateway] Update progress error:", error);
      goals = goals.map(g => g.id === id ? { ...g, currentProgress: progress } : g);
      saveLocalGoals(goals);
      notify();
      return false;
    }
  }
  
  return {
    get goals() { return goals; },
    get isLoading() { return isLoading; },
    get isError() { return isError; },
    get isSynced() { return isSynced; },
    load,
    add,
    update,
    delete: deleteGoal,
    complete,
    updateProgress,
  };
}

// React hook for using the goals gateway
import { useState, useEffect, useCallback, useRef } from "react";

export function useGoalsGateway() {
  const gatewayRef = useRef(createGoalsGateway());
  const [state, setState] = useState({
    goals: gatewayRef.current.goals,
    isLoading: gatewayRef.current.isLoading,
    isError: gatewayRef.current.isError,
    isSynced: gatewayRef.current.isSynced,
  });
  
  useEffect(() => {
    const update = () => {
      setState({
        goals: gatewayRef.current.goals,
        isLoading: gatewayRef.current.isLoading,
        isError: gatewayRef.current.isError,
        isSynced: gatewayRef.current.isSynced,
      });
    };
    
    gatewayRef.current.load();
    update();
  }, []);
  
  const load = useCallback(() => gatewayRef.current.load(), []);
  const add = useCallback((goal: Omit<Goal, "id" | "createdAt" | "completedAt">) => gatewayRef.current.add(goal), []);
  const update = useCallback((goal: Goal) => gatewayRef.current.update(goal), []);
  const deleteGoal = useCallback((id: string) => gatewayRef.current.delete(id), []);
  const complete = useCallback((id: string) => gatewayRef.current.complete(id), []);
  const updateProgress = useCallback((id: string, progress: number) => gatewayRef.current.updateProgress(id, progress), []);
  
  return {
    ...state,
    load,
    add,
    update,
    delete: deleteGoal,
    complete,
    updateProgress,
  };
}