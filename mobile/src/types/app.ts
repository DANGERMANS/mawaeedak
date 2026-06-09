/**
 * App Types — Mawaeedak Mobile
 */

// =============================================================================
// Tab Navigation Types
// =============================================================================

export type TabName = 'home' | 'salaries' | 'services' | 'calendar' | 'more';

export interface TabItem {
  name: TabName;
  icon: string;
  label: string;
}

// =============================================================================
// Services Types
// =============================================================================

export type ServiceType = 
  | 'goals'           // احسب هدفك
  | 'costs'           // حساب التكاليف
  | 'reminders'       // ذكرني
  | 'travel'          // السفر
  | 'study'           // الدراسة والإجازات
  | 'jobs'            // الوظائف والأخبار
  | 'dailyCard'       // بطاقة اليوم
  | 'feedback';      // صوتك مسموع

export interface ServiceItem {
  id: ServiceType;
  icon: string;
  label: string;
  description: string;
}

// =============================================================================
// Goals Types (احسب هدفك)
// =============================================================================

export interface Goal {
  id: string;
  name: string;
  type: 'financial' | 'other';
  targetValue?: number;
  currentValue?: number;
  deadline?: string;
  hijriDeadline?: string;
  createdAt: string;
  updatedAt: string;
  status: 'active' | 'completed' | 'paused';
}

// =============================================================================
// Cost Calculator Types (حساب التكاليف)
// =============================================================================

export interface CostProject {
  id: string;
  name: string;
  createdAt: string;
  updatedAt: string;
  status: 'active' | 'completed';
}

export interface CostItem {
  id: string;
  projectId: string;
  name: string;
  cost: number;
  status: 'unpaid' | 'partial' | 'paid' | 'scheduled';
  dueDate?: string;
  paidAt?: string;
  createdAt: string;
}

// =============================================================================
// Reminders Types (ذكرني)
// =============================================================================

export interface Reminder {
  id: string;
  title: string;
  date: string;
  hijriDate: string;
  time: string;
  notifyBefore: 'day' | 'hour';
  note?: string;
  createdAt: string;
  status: 'pending' | 'triggered' | 'dismissed';
}

// =============================================================================
// Travel Types (السفر)
// =============================================================================

export interface Trip {
  id: string;
  name: string;
  date: string;
  destination: string;
  documents: string[];
  checklist: TravelCheckItem[];
  reminders: string[];
  createdAt: string;
}

export interface TravelCheckItem {
  id: string;
  name: string;
  checked: boolean;
}

// =============================================================================
// Calendar Types (التقويم)
// =============================================================================

export type AppointmentCategory = 
  | 'personal'
  | 'family'
  | 'work'
  | 'travel'
  | 'health'
  | 'documents'
  | 'financial';

export type AppointmentPriority = 'low' | 'medium' | 'high';

export interface Appointment {
  id: string;
  title: string;
  date: string;
  hijriDate: string;
  time?: string;
  category: AppointmentCategory;
  priority: AppointmentPriority;
  notes?: string;
  reminder?: boolean;
  createdAt: string;
  updatedAt: string;
}

// =============================================================================
// Settings Types
// =============================================================================

export interface AppSettings {
  city: string;
  timeFormat: '12h' | '24h';
  notificationsEnabled: boolean;
  prayerTimeSource: 'auto' | 'manual';
  theme: 'light' | 'dark' | 'auto';
  language: 'ar';
}

// =============================================================================
// Financial Dates Types (Salaries Screen)
// =============================================================================

export interface FinancialDateItem {
  id: string;
  name: string;
  key: string;           // e.g., 'gov_salary', 'citizen_account'
  nextDate?: string;
  hijriNextDate?: string;
  countdown?: number;     // days until
  status: 'pending' | 'approved' | 'official';
  sourceAuthority?: string;
}

// =============================================================================
// API Response Types (for future linking)
// =============================================================================

export interface ApiResponse<T> {
  success: boolean;
  data?: T;
  error?: string;
}

export interface PaginatedResponse<T> {
  data: T[];
  total: number;
  page: number;
  limit: number;
}

// =============================================================================
// Local Storage Keys
// =============================================================================

export const STORAGE_KEYS = {
  // Goals
  GOALS: 'mawaeedak_goals_v1',
  
  // Cost Calculator
  COST_PROJECTS: 'mawaeedak_cost_projects_v1',
  COST_ITEMS: 'mawaeedak_cost_items_v1',
  
  // Reminders
  REMINDERS: 'mawaeedak_reminders_v1',
  
  // Travel
  TRIPS: 'mawaeedak_trips_v1',
  
  // Calendar
  APPOINTMENTS: 'mawaeedak_appointments_v1',
  
  // Settings
  SETTINGS: 'mawaeedak_settings_v1',
  
  // User
  USER_PROFILE: 'mawaeedak_user_v1',
} as const;