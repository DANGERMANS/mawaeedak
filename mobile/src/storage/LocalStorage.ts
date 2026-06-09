/**
 * Local Storage Service — Mawaeedak Mobile
 * 
 * AsyncStorage wrapper for local data persistence.
 * All data stored locally until real Supabase/API linking.
 */

import AsyncStorage from '@react-native-async-storage/async-storage';
import { STORAGE_KEYS } from '../types/app';

// =============================================================================
// Generic Storage Functions
// =============================================================================

export async function getItem<T>(key: string): Promise<T | null> {
  try {
    const value = await AsyncStorage.getItem(key);
    if (value) {
      return JSON.parse(value) as T;
    }
    return null;
  } catch (error) {
    console.error(`[Storage] Error getting ${key}:`, error);
    return null;
  }
}

export async function setItem<T>(key: string, value: T): Promise<boolean> {
  try {
    await AsyncStorage.setItem(key, JSON.stringify(value));
    return true;
  } catch (error) {
    console.error(`[Storage] Error setting ${key}:`, error);
    return false;
  }
}

export async function removeItem(key: string): Promise<boolean> {
  try {
    await AsyncStorage.removeItem(key);
    return true;
  } catch (error) {
    console.error(`[Storage] Error removing ${key}:`, error);
    return false;
  }
}

export async function clearAll(): Promise<boolean> {
  try {
    const keys = Object.values(STORAGE_KEYS);
    await AsyncStorage.multiRemove(keys);
    return true;
  } catch (error) {
    console.error('[Storage] Error clearing all:', error);
    return false;
  }
}

// =============================================================================
// Goals Storage
// =============================================================================

import type { Goal } from '../types/app';

export const goalsStorage = {
  async getAll(): Promise<Goal[]> {
    return (await getItem<Goal[]>(STORAGE_KEYS.GOALS)) || [];
  },
  
  async save(goals: Goal[]): Promise<boolean> {
    return setItem(STORAGE_KEYS.GOALS, goals);
  },
  
  async add(goal: Omit<Goal, 'id' | 'createdAt' | 'updatedAt'>): Promise<Goal | null> {
    const goals = await this.getAll();
    const newGoal: Goal = {
      ...goal,
      id: `goal_${Date.now()}`,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    };
    goals.push(newGoal);
    await this.save(goals);
    return newGoal;
  },
  
  async update(id: string, updates: Partial<Goal>): Promise<Goal | null> {
    const goals = await this.getAll();
    const index = goals.findIndex(g => g.id === id);
    if (index === -1) return null;
    goals[index] = { ...goals[index], ...updates, updatedAt: new Date().toISOString() };
    await this.save(goals);
    return goals[index];
  },
  
  async delete(id: string): Promise<boolean> {
    const goals = await this.getAll();
    const filtered = goals.filter(g => g.id !== id);
    if (filtered.length === goals.length) return false;
    await this.save(filtered);
    return true;
  },
};

// =============================================================================
// Cost Projects Storage
// =============================================================================

import type { CostProject, CostItem } from '../types/app';

export const costProjectsStorage = {
  async getAll(): Promise<CostProject[]> {
    return (await getItem<CostProject[]>(STORAGE_KEYS.COST_PROJECTS)) || [];
  },
  
  async save(projects: CostProject[]): Promise<boolean> {
    return setItem(STORAGE_KEYS.COST_PROJECTS, projects);
  },
  
  async add(name: string): Promise<CostProject | null> {
    const projects = await this.getAll();
    const newProject: CostProject = {
      id: `cost_${Date.now()}`,
      name,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
      status: 'active',
    };
    projects.push(newProject);
    await this.save(projects);
    return newProject;
  },
  
  async update(id: string, updates: Partial<CostProject>): Promise<CostProject | null> {
    const projects = await this.getAll();
    const index = projects.findIndex(p => p.id === id);
    if (index === -1) return null;
    projects[index] = { ...projects[index], ...updates, updatedAt: new Date().toISOString() };
    await this.save(projects);
    return projects[index];
  },
  
  async delete(id: string): Promise<boolean> {
    const projects = await this.getAll();
    const filtered = projects.filter(p => p.id !== id);
    await this.save(filtered);
    // Also delete associated items
    const items = await costItemsStorage.getAll();
    const filteredItems = items.filter(i => i.projectId !== id);
    await costItemsStorage.save(filteredItems);
    return true;
  },
};

export const costItemsStorage = {
  async getAll(): Promise<CostItem[]> {
    return (await getItem<CostItem[]>(STORAGE_KEYS.COST_ITEMS)) || [];
  },
  
  async getByProject(projectId: string): Promise<CostItem[]> {
    const items = await this.getAll();
    return items.filter(i => i.projectId === projectId);
  },
  
  async save(items: CostItem[]): Promise<boolean> {
    return setItem(STORAGE_KEYS.COST_ITEMS, items);
  },
  
  async add(item: Omit<CostItem, 'id' | 'createdAt'>): Promise<CostItem | null> {
    const items = await this.getAll();
    const newItem: CostItem = {
      ...item,
      id: `cost_item_${Date.now()}`,
      createdAt: new Date().toISOString(),
    };
    items.push(newItem);
    await this.save(items);
    return newItem;
  },
  
  async update(id: string, updates: Partial<CostItem>): Promise<CostItem | null> {
    const items = await this.getAll();
    const index = items.findIndex(i => i.id === id);
    if (index === -1) return null;
    items[index] = { ...items[index], ...updates };
    await this.save(items);
    return items[index];
  },
  
  async delete(id: string): Promise<boolean> {
    const items = await this.getAll();
    const filtered = items.filter(i => i.id !== id);
    await this.save(filtered);
    return true;
  },
};

// =============================================================================
// Reminders Storage
// =============================================================================

import type { Reminder } from '../types/app';

export const remindersStorage = {
  async getAll(): Promise<Reminder[]> {
    return (await getItem<Reminder[]>(STORAGE_KEYS.REMINDERS)) || [];
  },
  
  async save(reminders: Reminder[]): Promise<boolean> {
    return setItem(STORAGE_KEYS.REMINDERS, reminders);
  },
  
  async add(reminder: Omit<Reminder, 'id' | 'createdAt' | 'status'>): Promise<Reminder | null> {
    const reminders = await this.getAll();
    const newReminder: Reminder = {
      ...reminder,
      id: `reminder_${Date.now()}`,
      createdAt: new Date().toISOString(),
      status: 'pending',
    };
    reminders.push(newReminder);
    await this.save(reminders);
    return newReminder;
  },
  
  async update(id: string, updates: Partial<Reminder>): Promise<Reminder | null> {
    const reminders = await this.getAll();
    const index = reminders.findIndex(r => r.id === id);
    if (index === -1) return null;
    reminders[index] = { ...reminders[index], ...updates };
    await this.save(reminders);
    return reminders[index];
  },
  
  async delete(id: string): Promise<boolean> {
    const reminders = await this.getAll();
    const filtered = reminders.filter(r => r.id !== id);
    await this.save(filtered);
    return true;
  },
};

// =============================================================================
// Travel Storage
// =============================================================================

import type { Trip } from '../types/app';

export const tripsStorage = {
  async getAll(): Promise<Trip[]> {
    return (await getItem<Trip[]>(STORAGE_KEYS.TRIPS)) || [];
  },
  
  async save(trips: Trip[]): Promise<boolean> {
    return setItem(STORAGE_KEYS.TRIPS, trips);
  },
  
  async add(trip: Omit<Trip, 'id' | 'createdAt'>): Promise<Trip | null> {
    const trips = await this.getAll();
    const newTrip: Trip = {
      ...trip,
      id: `trip_${Date.now()}`,
      createdAt: new Date().toISOString(),
    };
    trips.push(newTrip);
    await this.save(trips);
    return newTrip;
  },
  
  async update(id: string, updates: Partial<Trip>): Promise<Trip | null> {
    const trips = await this.getAll();
    const index = trips.findIndex(t => t.id === id);
    if (index === -1) return null;
    trips[index] = { ...trips[index], ...updates };
    await this.save(trips);
    return trips[index];
  },
  
  async delete(id: string): Promise<boolean> {
    const trips = await this.getAll();
    const filtered = trips.filter(t => t.id !== id);
    await this.save(filtered);
    return true;
  },
};

// =============================================================================
// Appointments Storage
// =============================================================================

import type { Appointment } from '../types/app';

export const appointmentsStorage = {
  async getAll(): Promise<Appointment[]> {
    return (await getItem<Appointment[]>(STORAGE_KEYS.APPOINTMENTS)) || [];
  },
  
  async save(appointments: Appointment[]): Promise<boolean> {
    return setItem(STORAGE_KEYS.APPOINTMENTS, appointments);
  },
  
  async add(appointment: Omit<Appointment, 'id' | 'createdAt' | 'updatedAt'>): Promise<Appointment | null> {
    const appointments = await this.getAll();
    const newAppointment: Appointment = {
      ...appointment,
      id: `appt_${Date.now()}`,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    };
    appointments.push(newAppointment);
    await this.save(appointments);
    return newAppointment;
  },
  
  async update(id: string, updates: Partial<Appointment>): Promise<Appointment | null> {
    const appointments = await this.getAll();
    const index = appointments.findIndex(a => a.id === id);
    if (index === -1) return null;
    appointments[index] = { ...appointments[index], ...updates, updatedAt: new Date().toISOString() };
    await this.save(appointments);
    return appointments[index];
  },
  
  async delete(id: string): Promise<boolean> {
    const appointments = await this.getAll();
    const filtered = appointments.filter(a => a.id !== id);
    await this.save(filtered);
    return true;
  },
};

// =============================================================================
// Settings Storage
// =============================================================================

import type { AppSettings } from '../types/app';

const DEFAULT_SETTINGS: AppSettings = {
  city: 'الرياض',
  timeFormat: '12h',
  notificationsEnabled: true,
  prayerTimeSource: 'auto',
  theme: 'light',
  language: 'ar',
};

export const settingsStorage = {
  async get(): Promise<AppSettings> {
    const settings = await getItem<AppSettings>(STORAGE_KEYS.SETTINGS);
    return settings || DEFAULT_SETTINGS;
  },
  
  async save(settings: AppSettings): Promise<boolean> {
    return setItem(STORAGE_KEYS.SETTINGS, settings);
  },
  
  async update(updates: Partial<AppSettings>): Promise<AppSettings> {
    const current = await this.get();
    const updated = { ...current, ...updates };
    await this.save(updated);
    return updated;
  },
  
  async reset(): Promise<AppSettings> {
    await this.save(DEFAULT_SETTINGS);
    return DEFAULT_SETTINGS;
  },
};

// =============================================================================
// User Storage
// =============================================================================

export const userStorage = {
  async get(): Promise<{ name?: string; email?: string } | null> {
    return getItem(STORAGE_KEYS.USER_PROFILE);
  },
  
  async save(user: { name?: string; email?: string }): Promise<boolean> {
    return setItem(STORAGE_KEYS.USER_PROFILE, user);
  },
  
  async clear(): Promise<boolean> {
    return removeItem(STORAGE_KEYS.USER_PROFILE);
  },
};