import { useMemo, useState } from "react";
import { AppShell } from "@/components/layout/AppShell";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { ConfirmDialog } from "@/components/layout/ConfirmDialog";
import { useToast } from "@/hooks/use-toast";
import { useTimeFormat } from "@/hooks/useTimeFormat";
import { useQueryClient } from "@tanstack/react-query";
import { Calendar as CalIcon, ChevronLeft, ChevronRight, Clock, Loader2, Plus, Trash2 } from "lucide-react";
import { useGatewayAppointments, gwQueryKeys } from "@/hooks/useGatewayData";
import { useCreateOfficialAppointment, useDeleteOfficialAppointment, useOfficialAppointments, useUpdateOfficialAppointment } from "@/hooks/useOfficialData";
import { gwCreateAppointment, gwDeleteAppointment, gwUpdateAppointment } from "@/lib/dataGateway";
import type { Appointment } from "@workspace/api-client-react";
import { getListAppointmentsQueryKey, getListUpcomingAppointmentsQueryKey } from "@workspace/api-client-react";

type CalendarAppointment = Appointment & {
  color?: string | null;
  priority?: string | null;
  description?: string | null;
  time?: string | null;
};

const WEEKDAYS = ["أحد", "اثنين", "ثلاثاء", "أربع", "خميس", "جمعة", "سبت"];
const today = new Date().toISOString().split("T")[0] ?? "";

function buildCalendarGrid(year: number, month: number): Array<{ day: number | null; date: string | null }> {
  const firstDay = new Date(year, month, 1).getDay();
  const daysInMonth = new Date(year, month + 1, 0).getDate();
  const grid: Array<{ day: number | null; date: string | null }> = [];
  for (let i = 0; i < firstDay; i += 1) grid.push({ day: null, date: null });
  for (let d = 1; d <= daysInMonth; d += 1) {
    const mm = String(month + 1).padStart(2, "0");
    const dd = String(d).padStart(2, "0");
    grid.push({ day: d, date: `${year}-${mm}-${dd}` });
  }
  return grid;
}

function arMonthYear(date: Date): string {
  return date.toLocaleDateString("ar-SA-u-ca-gregory", { year: "numeric", month: "long" });
}

const Dia = () => (
  <svg viewBox="0 0 10 10" style={{ width: 7, height: 7 }} fill="hsl(var(--gold-muted))">
    <polygon points="5,0 10,5 5,10 0,5" />
  </svg>
);

export default function CalendarPage() {
  const { toast } = useToast();
  const { formatTime } = useTimeFormat();
  const queryClient = useQueryClient();
  const now = new Date();

  const [viewYear, setViewYear] = useState(now.getFullYear());
  const [viewMonth, setViewMonth] = useState(now.getMonth());
  const [selectedDate, setSelectedDate] = useState<string>(today);

  const { data: allAppointments, isLoading, refetch: refetchAppointments } = useGatewayAppointments();
  const { data: officialAppointments } = useOfficialAppointments();
  const createOfficialMutation = useCreateOfficialAppointment(["official-appointments"]);
  const updateOfficialMutation = useUpdateOfficialAppointment(["official-appointments"]);
  const deleteOfficialMutation = useDeleteOfficialAppointment(["official-appointments"]);

  const appointments = useMemo<CalendarAppointment[]>(() => {
    if (Array.isArray(officialAppointments) && officialAppointments.length > 0) {
      return officialAppointments as CalendarAppointment[];
    }
    return (allAppointments ?? []) as CalendarAppointment[];
  }, [officialAppointments, allAppointments]);

  const grid = useMemo(() => buildCalendarGrid(viewYear, viewMonth), [viewYear, viewMonth]);
  const datesWithAppts = useMemo(() => new Set(appointments.map((appointment) => appointment.date)), [appointments]);
  const listAppts = useMemo(
    () => appointments.filter((appointment) => appointment.date === selectedDate),
    [appointments, selectedDate],
  );

  const [isAddOpen, setIsAddOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);
  const [editApp, setEditApp] = useState<CalendarAppointment | null>(null);
  const [deleteId, setDeleteId] = useState<number | null>(null);
  const [savePending, setSavePending] = useState(false);
  const [deletePending, setDeletePending] = useState(false);

  const [title, setTitle] = useState("");
  const [date, setDate] = useState(today);
  const [time, setTime] = useState("");
  const [cat, setCat] = useState("شخصي");
  const [priority, setPriority] = useState("متوسطة");
  const [notes, setNotes] = useState("");

  const selectedDateLabel = selectedDate
    ? new Date(`${selectedDate}T00:00:00`).toLocaleDateString("ar-SA-u-ca-gregory", {
        weekday: "long",
        day: "numeric",
        month: "long",
      })
    : "";

  const invalidateAppointments = () => {
    queryClient.invalidateQueries({ queryKey: gwQueryKeys.appointments });
    queryClient.invalidateQueries({ queryKey: gwQueryKeys.upcomingAppointments });
    queryClient.invalidateQueries({ queryKey: getListAppointmentsQueryKey() });
    queryClient.invalidateQueries({ queryKey: getListUpcomingAppointmentsQueryKey() });
    queryClient.invalidateQueries({ queryKey: ["official-appointments"] });
    void refetchAppointments();
  };

  const resetForm = () => {
    setTitle("");
    setTime("");
    setNotes("");
    setDate(selectedDate || today);
    setCat("شخصي");
    setPriority("متوسطة");
  };

  const prevMonth = () => {
    if (viewMonth === 0) {
      setViewYear((year) => year - 1);
      setViewMonth(11);
      return;
    }
    setViewMonth((month) => month - 1);
  };

  const nextMonth = () => {
    if (viewMonth === 11) {
      setViewYear((year) => year + 1);
      setViewMonth(0);
      return;
    }
    setViewMonth((month) => month + 1);
  };

  const openEdit = (appointment: CalendarAppointment) => {
    setEditApp(appointment);
    setTitle(appointment.title);
    setDate(appointment.date);
    setTime(appointment.time ?? "");
    setCat(appointment.category);
    setPriority(appointment.priority ?? "متوسطة");
    setNotes(appointment.description ?? "");
    setIsEditOpen(true);
  };

  const handleAdd = async () => {
    if (!title || !date) {
      toast({ title: "خطأ", description: "الرجاء إدخال العنوان والتاريخ", variant: "destructive" });
      return;
    }
    setSavePending(true);
    try {
      if (Array.isArray(officialAppointments)) {
        await createOfficialMutation.mutateAsync({ title, date, time: time || undefined, category: cat, priority, description: notes || undefined, color: "#9c6a1a" });
      } else {
        const result = await gwCreateAppointment({ title, date, time: time || undefined, category: cat, priority, description: notes || undefined, color: "#9c6a1a" });
        if (!result.success) throw new Error(result.error ?? "خطأ غير معروف");
      }
      toast({ title: "تم الإضافة" });
      setIsAddOpen(false);
      resetForm();
      invalidateAppointments();
    } catch (error) {
      toast({ title: "فشل الإضافة", description: error instanceof Error ? error.message : "خطأ غير معروف", variant: "destructive" });
    } finally {
      setSavePending(false);
    }
  };

  const handleEdit = async () => {
    if (!editApp) return;
    setSavePending(true);
    try {
      const payload = { title, date, time: time || undefined, category: cat, priority, description: notes || undefined };
      if (Array.isArray(officialAppointments)) {
        await updateOfficialMutation.mutateAsync({ id: editApp.id, data: payload });
      } else {
        const result = await gwUpdateAppointment(editApp.id, payload);
        if (!result.success) throw new Error(result.error ?? "خطأ غير معروف");
      }
      toast({ title: "تم التعديل" });
      setIsEditOpen(false);
      invalidateAppointments();
    } catch (error) {
      toast({ title: "فشل التعديل", description: error instanceof Error ? error.message : "خطأ غير معروف", variant: "destructive" });
    } finally {
      setSavePending(false);
    }
  };

  const handleDelete = async () => {
    if (!deleteId) return;
    setDeletePending(true);
    try {
      if (Array.isArray(officialAppointments)) {
        await deleteOfficialMutation.mutateAsync(deleteId);
      } else {
        const result = await gwDeleteAppointment(deleteId);
        if (!result.success) throw new Error(result.error ?? "خطأ غير معروف");
      }
      toast({ title: "تم الحذف" });
      setDeleteId(null);
      setIsEditOpen(false);
      setIsDeleteOpen(false);
      invalidateAppointments();
    } catch (error) {
      toast({ title: "فشل الحذف", description: error instanceof Error ? error.message : "خطأ غير معروف", variant: "destructive" });
      setIsDeleteOpen(false);
    } finally {
      setDeletePending(false);
    }
  };

  const appointmentDialogBody = (
    <div className="space-y-4 py-4">
      <div className="space-y-2">
        <Label>العنوان</Label>
        <Input value={title} onChange={(event) => setTitle(event.target.value)} />
      </div>
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-2">
          <Label>التاريخ</Label>
          <Input type="date" value={date} onChange={(event) => setDate(event.target.value)} />
        </div>
        <div className="space-y-2">
          <Label>الوقت</Label>
          <Input type="time" value={time} onChange={(event) => setTime(event.target.value)} />
        </div>
      </div>
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-2">
          <Label>التصنيف</Label>
          <Select value={cat} onValueChange={setCat}>
            <SelectTrigger><SelectValue /></SelectTrigger>
            <SelectContent className="rtl">
              <SelectItem value="شخصي">شخصي</SelectItem>
              <SelectItem value="عائلي">عائلي</SelectItem>
              <SelectItem value="عمل">عمل</SelectItem>
              <SelectItem value="صحة">صحة</SelectItem>
              <SelectItem value="مال">مال</SelectItem>
            </SelectContent>
          </Select>
        </div>
        <div className="space-y-2">
          <Label>الأهمية</Label>
          <Select value={priority} onValueChange={setPriority}>
            <SelectTrigger><SelectValue /></SelectTrigger>
            <SelectContent className="rtl">
              <SelectItem value="عالية">عالية</SelectItem>
              <SelectItem value="متوسطة">متوسطة</SelectItem>
              <SelectItem value="منخفضة">منخفضة</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </div>
      <div className="space-y-2">
        <Label>ملاحظات</Label>
        <Textarea value={notes} onChange={(event) => setNotes(event.target.value)} rows={3} />
      </div>
    </div>
  );

  return (
    <AppShell title="التقويم">
      <div className="space-y-3 pb-2">
        <div className="-mx-3 rounded-b-3xl overflow-hidden" style={{ background: "linear-gradient(160deg, hsl(36 38% 96%) 0%, hsl(34 32% 92%) 100%)", border: "1.5px solid hsl(34 45% 64% / 0.70)", borderTop: "none" }}>
          <div className="flex items-center justify-between px-4 py-3" style={{ background: "linear-gradient(135deg, hsl(22 58% 20%) 0%, hsl(18 68% 14%) 100%)" }}>
            <button onClick={nextMonth} className="w-8 h-8 flex items-center justify-center rounded-xl hover:bg-white/10" style={{ color: "hsl(38 74% 62%)" }}><ChevronRight className="w-5 h-5" /></button>
            <div className="flex items-center gap-2"><Dia /><span className="text-[16px] font-extrabold" style={{ color: "hsl(38 86% 88%)" }}>{arMonthYear(new Date(viewYear, viewMonth, 1))}</span><Dia /></div>
            <button onClick={prevMonth} className="w-8 h-8 flex items-center justify-center rounded-xl hover:bg-white/10" style={{ color: "hsl(38 74% 62%)" }}><ChevronLeft className="w-5 h-5" /></button>
          </div>

          <div className="grid grid-cols-7 px-2 py-1.5" style={{ borderBottom: "1px solid hsl(34 38% 78% / 0.50)" }}>
            {WEEKDAYS.map((day) => <div key={day} className="text-center text-[11px] font-bold" style={{ color: "hsl(22 55% 38%)" }}>{day}</div>)}
          </div>

          <div className="grid grid-cols-7 gap-y-0.5 px-2 py-2">
            {grid.map((cell, index) => {
              if (!cell.day || !cell.date) return <div key={`empty-${index}`} />;
              const isToday = cell.date === today;
              const isSelected = cell.date === selectedDate;
              const hasAppointment = datesWithAppts.has(cell.date);
              return (
                <button key={cell.date} onClick={() => setSelectedDate(cell.date ?? today)} className="relative flex flex-col items-center justify-center py-1">
                  <span className="w-8 h-8 flex items-center justify-center rounded-full text-[13px] font-bold" style={{ background: isSelected ? "hsl(22 62% 22%)" : isToday ? "hsl(38 72% 50%)" : "transparent", color: isSelected || isToday ? "#fff" : "hsl(22 40% 28%)" }}>{cell.day}</span>
                  {hasAppointment && <span className="absolute bottom-0.5 left-1/2 -translate-x-1/2 w-1 h-1 rounded-full" style={{ background: "hsl(38 72% 50%)" }} />}
                </button>
              );
            })}
          </div>
        </div>

        <div className="flex items-center justify-between">
          <div className="flex items-center gap-1.5"><Dia /><span className="text-[13px] font-bold" style={{ color: "hsl(22 48% 32%)" }}>{selectedDateLabel || "اختر يوماً"}</span></div>
          <Dialog open={isAddOpen} onOpenChange={(open) => { setIsAddOpen(open); if (!open) resetForm(); }}>
            <DialogTrigger asChild><Button size="sm" className="h-8 gap-1 font-bold text-[13px] px-3" onClick={() => setDate(selectedDate || today)}><Plus className="w-3.5 h-3.5" />إضافة</Button></DialogTrigger>
            <DialogContent className="rtl max-w-[400px] rounded-xl max-h-[90vh] overflow-y-auto">
              <DialogHeader><DialogTitle>موعد جديد</DialogTitle></DialogHeader>
              {appointmentDialogBody}
              <Button className="w-full" onClick={handleAdd} disabled={savePending}>{savePending ? <Loader2 className="w-4 h-4 animate-spin" /> : "حفظ الموعد"}</Button>
            </DialogContent>
          </Dialog>
        </div>

        <div className="space-y-2.5">
          {isLoading ? (
            <div className="flex justify-center p-8"><Loader2 className="w-6 h-6 animate-spin" /></div>
          ) : listAppts.length > 0 ? (
            listAppts.map((appointment) => (
              <div key={appointment.id} className="rounded-2xl overflow-hidden cursor-pointer transition-all duration-200 hover:shadow-md active:scale-[0.98]" style={{ background: "linear-gradient(145deg, hsl(var(--card)) 0%, hsl(36 28% 91%) 100%)", border: "1px solid hsl(var(--card-border))", borderRight: `4px solid ${appointment.color || "hsl(var(--primary))"}` }} onClick={() => openEdit(appointment)}>
                <div className="p-4">
                  <div className="flex justify-between items-start mb-2"><h4 className="font-bold text-[15px] text-foreground">{appointment.title}</h4><span className="text-[10px] px-2 py-1 rounded-lg font-semibold">{appointment.category}</span></div>
                  <div className="flex flex-wrap gap-x-4 gap-y-1.5 text-xs text-muted-foreground">
                    {appointment.time && <div className="flex items-center gap-1.5"><Clock className="w-3 h-3" /><span className="font-medium">{formatTime(appointment.time)}</span></div>}
                    {appointment.priority && <span className="px-1.5 py-0.5 rounded-md text-[10px] font-semibold">{appointment.priority}</span>}
                  </div>
                  {appointment.description && <p className="text-xs text-muted-foreground mt-2.5 line-clamp-1 pt-2">{appointment.description}</p>}
                </div>
              </div>
            ))
          ) : (
            <div className="text-center py-10 rounded-2xl" style={{ background: "hsl(var(--card)/0.6)", border: "1.5px dashed hsl(var(--border)/0.7)" }}>
              <CalIcon className="w-10 h-10 mx-auto mb-3 opacity-35" />
              <p className="text-base font-bold text-foreground">لا توجد مواعيد</p>
              <p className="text-sm text-muted-foreground mt-1">{selectedDate === today ? "لا توجد مواعيد اليوم" : "لا توجد مواعيد في هذا اليوم"}</p>
            </div>
          )}
        </div>

        <Dialog open={isEditOpen} onOpenChange={setIsEditOpen}>
          <DialogContent className="rtl max-w-[400px] rounded-xl max-h-[90vh] overflow-y-auto">
            <DialogHeader><DialogTitle>تعديل الموعد</DialogTitle></DialogHeader>
            {appointmentDialogBody}
            <div className="flex gap-2 pt-2">
              <Button className="flex-1" onClick={handleEdit} disabled={savePending}>{savePending ? <Loader2 className="w-4 h-4 animate-spin" /> : "حفظ التعديلات"}</Button>
              <Button variant="destructive" size="icon" onClick={() => { setDeleteId(editApp?.id ?? null); setIsDeleteOpen(true); }} disabled={deletePending}><Trash2 className="w-4 h-4" /></Button>
            </div>
          </DialogContent>
        </Dialog>

        <ConfirmDialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen} title="حذف الموعد" description="هل أنت متأكد من حذف هذا الموعد؟ لا يمكن التراجع عن هذا الإجراء." onConfirm={handleDelete} />
      </div>
    </AppShell>
  );
}
