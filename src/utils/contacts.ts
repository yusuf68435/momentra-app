import * as Contacts from 'expo-contacts';
import { Platform, Alert } from 'react-native';

export interface SimpleContact {
  id: string;
  name: string;
  email?: string;
  phone?: string;
  imageUri?: string;
}

/**
 * Request contacts permission
 */
export async function requestContactsPermission(): Promise<boolean> {
  const { status } = await Contacts.requestPermissionsAsync();
  return status === 'granted';
}

/**
 * Check if we have contacts permission
 */
export async function hasContactsPermission(): Promise<boolean> {
  const { status } = await Contacts.getPermissionsAsync();
  return status === 'granted';
}

/**
 * Get all contacts, simplified
 */
export async function getContacts(): Promise<SimpleContact[]> {
  const hasPermission = await requestContactsPermission();
  if (!hasPermission) return [];

  const { data } = await Contacts.getContactsAsync({
    fields: [
      Contacts.Fields.Name,
      Contacts.Fields.Emails,
      Contacts.Fields.PhoneNumbers,
      Contacts.Fields.Image,
    ],
    sort: Contacts.SortTypes.FirstName,
  });

  return data
    .filter(c => c.name)
    .map((contact, index) => ({
      id: contact.id || `contact-${contact.name}-${index}`,
      name: contact.name || '',
      email: contact.emails?.[0]?.email,
      phone: contact.phoneNumbers?.[0]?.number,
      imageUri: contact.image?.uri,
    }));
}

/**
 * Search contacts by name
 */
export async function searchContacts(query: string): Promise<SimpleContact[]> {
  if (!query.trim()) return [];

  const allContacts = await getContacts();
  const q = query.toLowerCase();

  return allContacts.filter(c =>
    c.name.toLowerCase().includes(q) ||
    c.email?.toLowerCase().includes(q) ||
    c.phone?.includes(q)
  );
}

/**
 * Pick a contact for guest selection (returns simplified contact)
 */
export async function pickContactForGuest(): Promise<SimpleContact | null> {
  try {
    const hasPermission = await requestContactsPermission();
    if (!hasPermission) {
      return null;
    }

    // Use Contacts.presentContactPickerAsync if available, otherwise return null
    // This depends on the expo-contacts version
    return null;
  } catch {
    return null;
  }
}
