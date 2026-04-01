import { create } from "zustand";
import type {
  CoOrganizer,
  PlanMessage,
  TaskAssignment,
  InviteLink,
} from "../types/coOrganizer";
import * as coOrganizerService from "../services/coOrganizer";

interface CoOrganizerState {
  coOrganizers: CoOrganizer[];
  tasks: TaskAssignment[];
  messages: PlanMessage[];
  pendingInvites: CoOrganizer[];
  myInvites: CoOrganizer[];
  inviteLinks: InviteLink[];
  loadingCoOrganizers: boolean;
  loadingTasks: boolean;
  loadingMessages: boolean;

  loadCoOrganizers: (planId: string) => Promise<void>;
  loadTasks: (planId: string) => Promise<void>;
  loadMessages: (planId: string) => Promise<void>;
  loadPendingInvites: (planId: string) => Promise<void>;
  loadMyInvites: () => Promise<void>;
  invite: (
    planId: string,
    email: string,
    role: "organizer" | "helper",
  ) => Promise<boolean>;
  acceptInvite: (code: string) => Promise<boolean>;
  declineInvite: (coOrganizerId: string) => Promise<boolean>;
  removeCoOrganizer: (planId: string, userId: string) => Promise<void>;
  updateRole: (
    planId: string,
    userId: string,
    newRole: "organizer" | "helper",
  ) => Promise<void>;
  createTask: (
    planId: string,
    task: { checklistItemId: string; assignedTo: string },
  ) => Promise<void>;
  toggleTask: (taskId: string) => Promise<void>;
  deleteTask: (taskId: string) => Promise<void>;
  sendMessage: (planId: string, message: string) => Promise<void>;
  createInviteLink: (planId: string) => Promise<InviteLink | null>;
  loadInviteLinks: (planId: string) => Promise<void>;
  fetchChecklistItems: (
    planId: string,
  ) => Promise<{ id: string; title: string }[]>;
  createChecklistItem: (
    planId: string,
    title: string,
    sortOrder: number,
  ) => Promise<{ id: string; title: string } | null>;
}

export const useCoOrganizerStore = create<CoOrganizerState>()((set, get) => ({
  coOrganizers: [],
  tasks: [],
  messages: [],
  pendingInvites: [],
  myInvites: [],
  inviteLinks: [],
  loadingCoOrganizers: false,
  loadingTasks: false,
  loadingMessages: false,

  loadCoOrganizers: async (planId: string) => {
    set({ loadingCoOrganizers: true });
    try {
      const coOrganizers = await coOrganizerService.fetchCoOrganizers(planId);
      set({ coOrganizers });
    } catch (err) {
      if (__DEV__) console.warn("Failed to load co-organizers:", err);
      throw err;
    } finally {
      set({ loadingCoOrganizers: false });
    }
  },

  loadTasks: async (planId: string) => {
    set({ loadingTasks: true });
    try {
      const tasks = await coOrganizerService.fetchTasks(planId);
      set({ tasks });
    } catch (err) {
      if (__DEV__) console.warn("Failed to load tasks:", err);
      throw err;
    } finally {
      set({ loadingTasks: false });
    }
  },

  loadMessages: async (planId: string) => {
    set({ loadingMessages: true });
    try {
      const messages = await coOrganizerService.fetchMessages(planId);
      set({ messages });
    } catch (err) {
      if (__DEV__) console.warn("Failed to load messages:", err);
      throw err;
    } finally {
      set({ loadingMessages: false });
    }
  },

  loadPendingInvites: async (planId: string) => {
    try {
      const pendingInvites =
        await coOrganizerService.fetchPendingInvites(planId);
      set({ pendingInvites });
    } catch (err) {
      if (__DEV__) console.warn("Failed to load pending invites:", err);
    }
  },

  loadMyInvites: async () => {
    try {
      const myInvites = await coOrganizerService.fetchMyInvites();
      set({ myInvites });
    } catch (err) {
      if (__DEV__) console.warn("Failed to load my invites:", err);
    }
  },

  invite: async (
    planId: string,
    email: string,
    role: "organizer" | "helper",
  ) => {
    try {
      const result = await coOrganizerService.inviteCoOrganizer(
        planId,
        email,
        role,
      );
      if (result) {
        const { coOrganizers } = get();
        set({ coOrganizers: [...coOrganizers, result] });
        return true;
      }
      return false;
    } catch (err) {
      if (__DEV__) console.warn("Failed to invite:", err);
      return false;
    }
  },

  acceptInvite: async (code: string) => {
    try {
      const success = await coOrganizerService.acceptInvite(code);
      if (success) {
        const myInvites = await coOrganizerService.fetchMyInvites();
        set({ myInvites });
      }
      return success;
    } catch (err) {
      if (__DEV__) console.warn("Failed to accept invite:", err);
      return false;
    }
  },

  declineInvite: async (coOrganizerId: string) => {
    try {
      const success = await coOrganizerService.declineInvite(coOrganizerId);
      if (success) {
        const { myInvites } = get();
        set({ myInvites: myInvites.filter((i) => i.id !== coOrganizerId) });
      }
      return success;
    } catch (err) {
      if (__DEV__) console.warn("Failed to decline invite:", err);
      return false;
    }
  },

  removeCoOrganizer: async (planId: string, userId: string) => {
    const { coOrganizers } = get();
    // Optimistic
    set({ coOrganizers: coOrganizers.filter((c) => c.user_id !== userId) });
    try {
      await coOrganizerService.removeCoOrganizer(planId, userId);
    } catch (err) {
      // Rollback
      set({ coOrganizers });
      if (__DEV__) console.warn("Failed to remove co-organizer:", err);
      throw err;
    }
  },

  updateRole: async (
    planId: string,
    userId: string,
    newRole: "organizer" | "helper",
  ) => {
    const { coOrganizers } = get();
    // Optimistic
    set({
      coOrganizers: coOrganizers.map((c) =>
        c.user_id === userId ? { ...c, role: newRole } : c,
      ),
    });
    try {
      await coOrganizerService.updateRole(planId, userId, newRole);
    } catch (err) {
      // Rollback
      set({ coOrganizers });
      if (__DEV__) console.warn("Failed to update role:", err);
      throw err;
    }
  },

  createTask: async (
    planId: string,
    task: { checklistItemId: string; assignedTo: string },
  ) => {
    try {
      const newTask = await coOrganizerService.createTask(planId, task);
      if (newTask) {
        const { tasks } = get();
        set({ tasks: [newTask, ...tasks] });
      }
    } catch (err) {
      if (__DEV__) console.warn("Failed to create task:", err);
      throw err;
    }
  },

  toggleTask: async (taskId: string) => {
    const { tasks } = get();
    // Optimistic
    set({
      tasks: tasks.map((item) =>
        item.id === taskId
          ? {
              ...item,
              status:
                item.status === "completed"
                  ? ("pending" as const)
                  : ("completed" as const),
            }
          : item,
      ),
    });

    try {
      await coOrganizerService.toggleTaskComplete(taskId);
    } catch (err) {
      // Rollback
      set({ tasks });
      if (__DEV__) console.warn("Failed to toggle task:", err);
      throw err;
    }
  },

  deleteTask: async (taskId: string) => {
    const { tasks } = get();
    // Optimistic
    set({ tasks: tasks.filter((item) => item.id !== taskId) });

    try {
      await coOrganizerService.deleteTask(taskId);
    } catch (err) {
      // Rollback
      set({ tasks });
      if (__DEV__) console.warn("Failed to delete task:", err);
      throw err;
    }
  },

  sendMessage: async (planId: string, message: string) => {
    try {
      const newMessage = await coOrganizerService.sendMessage(planId, message);
      if (newMessage) {
        const { messages } = get();
        set({ messages: [newMessage, ...messages] });
      }
    } catch (err) {
      if (__DEV__) console.warn("Failed to send message:", err);
      throw err;
    }
  },

  createInviteLink: async (planId: string) => {
    try {
      const link = await coOrganizerService.createInviteLink(planId);
      if (link) {
        const { inviteLinks } = get();
        set({ inviteLinks: [link, ...inviteLinks] });
      }
      return link;
    } catch (err) {
      if (__DEV__) console.warn("Failed to create invite link:", err);
      return null;
    }
  },

  loadInviteLinks: async (planId: string) => {
    try {
      const inviteLinks =
        await coOrganizerService.fetchActiveInviteLinks(planId);
      set({ inviteLinks });
    } catch (err) {
      if (__DEV__) console.warn("Failed to load invite links:", err);
    }
  },

  fetchChecklistItems: async (planId: string) => {
    try {
      const items = await coOrganizerService.fetchChecklistItems(planId);
      return items ?? [];
    } catch {
      return [];
    }
  },

  createChecklistItem: async (
    planId: string,
    title: string,
    sortOrder: number,
  ) => {
    try {
      const item = await coOrganizerService.createChecklistItem(
        planId,
        title,
        sortOrder,
      );
      return item ?? null;
    } catch {
      return null;
    }
  },
}));
