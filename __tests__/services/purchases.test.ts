import {
  deriveStatusFromCustomerInfo,
  isPurchasesConfigured,
} from "../../src/services/purchases";
import type {
  CustomerInfo,
  SubscriptionStatus,
} from "../../src/services/purchases";

// ── deriveStatusFromCustomerInfo ────────────────────────────────────

describe("purchases – deriveStatusFromCustomerInfo", () => {
  const makeCustomerInfo = (
    activeEntitlements: Record<
      string,
      { isActive: boolean; expirationDate?: string }
    >,
  ): CustomerInfo => ({
    entitlements: { active: activeEntitlements },
  });

  it("returns pro plan when pro entitlement is active", () => {
    const info = makeCustomerInfo({
      pro: { isActive: true, expirationDate: "2027-01-01T00:00:00Z" },
    });
    const status = deriveStatusFromCustomerInfo(info);
    expect(status).toEqual<SubscriptionStatus>({
      plan: "pro",
      isActive: true,
      expiresAt: "2027-01-01T00:00:00Z",
    });
  });

  it("returns plus plan when only plus entitlement is active", () => {
    const info = makeCustomerInfo({
      plus: { isActive: true, expirationDate: "2027-06-15T00:00:00Z" },
    });
    const status = deriveStatusFromCustomerInfo(info);
    expect(status).toEqual<SubscriptionStatus>({
      plan: "plus",
      isActive: true,
      expiresAt: "2027-06-15T00:00:00Z",
    });
  });

  it("returns pro plan when both pro and plus entitlements are active", () => {
    const info = makeCustomerInfo({
      pro: { isActive: true, expirationDate: "2027-12-31T00:00:00Z" },
      plus: { isActive: true, expirationDate: "2027-06-15T00:00:00Z" },
    });
    const status = deriveStatusFromCustomerInfo(info);
    expect(status.plan).toBe("pro");
  });

  it("returns free plan when no entitlements are active", () => {
    const info = makeCustomerInfo({});
    const status = deriveStatusFromCustomerInfo(info);
    expect(status).toEqual<SubscriptionStatus>({
      plan: "free",
      isActive: false,
      expiresAt: null,
    });
  });

  it("handles entitlement without expirationDate", () => {
    const info = makeCustomerInfo({
      plus: { isActive: true },
    });
    const status = deriveStatusFromCustomerInfo(info);
    expect(status.expiresAt).toBeNull();
    expect(status.plan).toBe("plus");
    expect(status.isActive).toBe(true);
  });
});

// ── isPurchasesConfigured ───────────────────────────────────────────

describe("purchases – isPurchasesConfigured", () => {
  it("returns false when SDK is not initialized", () => {
    // In test environment, native module is not available
    expect(isPurchasesConfigured()).toBe(false);
  });
});
