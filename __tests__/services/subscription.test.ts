import {
  hasFeature,
  getLimit,
  canPerformAction,
  isPlanAtLeast,
  PLAN_FEATURES,
  formatLimit,
  minimumPlanFor,
} from "../../src/services/subscription";
import type {
  SubscriptionPlan,
  PlanFeatures,
} from "../../src/services/subscription";

// ── hasFeature ───────────────────────────────────────────────────────

// v1.0: paywall bypassed. These tests document v1.1+ gating; skipped until IAP re-enabled.
describe.skip("subscription – hasFeature", () => {
  // Boolean features
  describe("boolean features", () => {
    it("free plan does NOT have premiumScenarios", () => {
      expect(hasFeature("free", "premiumScenarios")).toBe(false);
    });

    it("plus plan HAS premiumScenarios", () => {
      expect(hasFeature("plus", "premiumScenarios")).toBe(true);
    });

    it("pro plan HAS premiumScenarios", () => {
      expect(hasFeature("pro", "premiumScenarios")).toBe(true);
    });

    it("free plan does NOT have exportPDF", () => {
      expect(hasFeature("free", "exportPDF")).toBe(false);
    });

    it("plus plan HAS exportPDF", () => {
      expect(hasFeature("plus", "exportPDF")).toBe(true);
    });

    it("free plan does NOT have prioritySupport", () => {
      expect(hasFeature("free", "prioritySupport")).toBe(false);
    });

    it("plus plan does NOT have prioritySupport", () => {
      expect(hasFeature("plus", "prioritySupport")).toBe(false);
    });

    it("pro plan HAS prioritySupport", () => {
      expect(hasFeature("pro", "prioritySupport")).toBe(true);
    });

    it("free plan does NOT have customThemes", () => {
      expect(hasFeature("free", "customThemes")).toBe(false);
    });

    it("plus plan HAS customThemes", () => {
      expect(hasFeature("plus", "customThemes")).toBe(true);
    });
  });

  // Numeric features (treated as "has feature" if > 0)
  describe("numeric features", () => {
    it("all plans have maxPlans (> 0)", () => {
      expect(hasFeature("free", "maxPlans")).toBe(true);
      expect(hasFeature("plus", "maxPlans")).toBe(true);
      expect(hasFeature("pro", "maxPlans")).toBe(true);
    });

    it("all plans have maxAiChats (> 0)", () => {
      expect(hasFeature("free", "maxAiChats")).toBe(true);
      expect(hasFeature("plus", "maxAiChats")).toBe(true);
      expect(hasFeature("pro", "maxAiChats")).toBe(true);
    });
  });
});

// ── getLimit ─────────────────────────────────────────────────────────

// v1.0: paywall bypassed. These tests document v1.1+ gating; skipped until IAP re-enabled.
describe.skip("subscription – getLimit", () => {
  it("returns 3 for free plan maxPlans", () => {
    expect(getLimit("free", "maxPlans")).toBe(3);
  });

  it("returns 20 for plus plan maxPlans", () => {
    expect(getLimit("plus", "maxPlans")).toBe(20);
  });

  it("returns MAX_SAFE_INTEGER for pro plan maxPlans", () => {
    expect(getLimit("pro", "maxPlans")).toBe(Number.MAX_SAFE_INTEGER);
  });

  it("returns 5 for free plan maxAiChats", () => {
    expect(getLimit("free", "maxAiChats")).toBe(5);
  });

  it("returns 50 for plus plan maxAiChats", () => {
    expect(getLimit("plus", "maxAiChats")).toBe(50);
  });

  it("returns 1 for free plan coOrganizers", () => {
    expect(getLimit("free", "coOrganizers")).toBe(1);
  });

  it("returns 5 for plus plan coOrganizers", () => {
    expect(getLimit("plus", "coOrganizers")).toBe(5);
  });

  it("returns 0 for boolean features that are false", () => {
    expect(getLimit("free", "premiumScenarios")).toBe(0);
    expect(getLimit("free", "exportPDF")).toBe(0);
  });

  it("returns 1 for boolean features that are true", () => {
    expect(getLimit("plus", "premiumScenarios")).toBe(1);
    expect(getLimit("pro", "prioritySupport")).toBe(1);
  });

  it("returns correct photo storage limits", () => {
    expect(getLimit("free", "photoStorage")).toBe(10 * 1024 * 1024);
    expect(getLimit("plus", "photoStorage")).toBe(500 * 1024 * 1024);
    expect(getLimit("pro", "photoStorage")).toBe(5 * 1024 * 1024 * 1024);
  });
});

// ── canPerformAction ─────────────────────────────────────────────────

// v1.0: paywall bypassed. These tests document v1.1+ gating; skipped until IAP re-enabled.
describe.skip("subscription – canPerformAction", () => {
  describe("numeric limits", () => {
    it("allows action when usage is below limit", () => {
      expect(canPerformAction("free", "maxPlans", 0)).toBe(true);
      expect(canPerformAction("free", "maxPlans", 2)).toBe(true);
    });

    it("blocks action when usage equals the limit", () => {
      expect(canPerformAction("free", "maxPlans", 3)).toBe(false);
    });

    it("blocks action when usage exceeds the limit", () => {
      expect(canPerformAction("free", "maxPlans", 5)).toBe(false);
    });

    it("allows more actions on higher plans", () => {
      // Free: 5 AI chats, Plus: 50
      expect(canPerformAction("free", "maxAiChats", 5)).toBe(false);
      expect(canPerformAction("plus", "maxAiChats", 5)).toBe(true);
    });

    it("pro plan effectively allows unlimited actions", () => {
      expect(canPerformAction("pro", "maxPlans", 1000)).toBe(true);
      expect(canPerformAction("pro", "maxAiChats", 1000000)).toBe(true);
    });
  });

  describe("boolean features", () => {
    it("returns false for exportPDF on free plan regardless of usage", () => {
      expect(canPerformAction("free", "exportPDF", 0)).toBe(false);
    });

    it("returns true for exportPDF on plus plan", () => {
      expect(canPerformAction("plus", "exportPDF", 0)).toBe(true);
    });

    it("returns false for premiumScenarios on free plan", () => {
      expect(canPerformAction("free", "premiumScenarios", 0)).toBe(false);
    });

    it("returns true for premiumScenarios on plus plan", () => {
      expect(canPerformAction("plus", "premiumScenarios", 0)).toBe(true);
    });

    it("returns true for prioritySupport only on pro plan", () => {
      expect(canPerformAction("free", "prioritySupport", 0)).toBe(false);
      expect(canPerformAction("plus", "prioritySupport", 0)).toBe(false);
      expect(canPerformAction("pro", "prioritySupport", 0)).toBe(true);
    });
  });
});

// ── isPlanAtLeast ────────────────────────────────────────────────────

// v1.0: paywall bypassed. These tests document v1.1+ gating; skipped until IAP re-enabled.
describe.skip("subscription – isPlanAtLeast", () => {
  it("free is at least free", () => {
    expect(isPlanAtLeast("free", "free")).toBe(true);
  });

  it("free is NOT at least plus", () => {
    expect(isPlanAtLeast("free", "plus")).toBe(false);
  });

  it("plus is at least free", () => {
    expect(isPlanAtLeast("plus", "free")).toBe(true);
  });

  it("plus is at least plus", () => {
    expect(isPlanAtLeast("plus", "plus")).toBe(true);
  });

  it("plus is NOT at least pro", () => {
    expect(isPlanAtLeast("plus", "pro")).toBe(false);
  });

  it("pro is at least any plan", () => {
    expect(isPlanAtLeast("pro", "free")).toBe(true);
    expect(isPlanAtLeast("pro", "plus")).toBe(true);
    expect(isPlanAtLeast("pro", "pro")).toBe(true);
  });
});

// ── formatLimit ──────────────────────────────────────────────────────

// v1.0: paywall bypassed. These tests document v1.1+ gating; skipped until IAP re-enabled.
describe.skip("subscription – formatLimit", () => {
  it("formats boolean feature as Evet/Hayir in Turkish", () => {
    expect(formatLimit("plus", "premiumScenarios", "tr")).toBe("Evet");
    expect(formatLimit("free", "premiumScenarios", "tr")).toBe("Hayır");
  });

  it("formats boolean feature as Yes/No in English", () => {
    expect(formatLimit("plus", "premiumScenarios", "en")).toBe("Yes");
    expect(formatLimit("free", "premiumScenarios", "en")).toBe("No");
  });

  it("formats unlimited values correctly", () => {
    expect(formatLimit("pro", "maxPlans", "tr")).toBe("Sınırsız");
    expect(formatLimit("pro", "maxPlans", "en")).toBe("Unlimited");
  });

  it("formats photo storage in MB", () => {
    expect(formatLimit("free", "photoStorage")).toBe("10 MB");
    expect(formatLimit("plus", "photoStorage")).toBe("500 MB");
  });

  it("formats photo storage in GB", () => {
    expect(formatLimit("pro", "photoStorage")).toBe("5 GB");
  });

  it("formats numeric limits as strings", () => {
    expect(formatLimit("free", "maxPlans")).toBe("3");
    expect(formatLimit("plus", "maxAiChats")).toBe("50");
  });
});

// ── minimumPlanFor ───────────────────────────────────────────────────

// v1.0: paywall bypassed. These tests document v1.1+ gating; skipped until IAP re-enabled.
describe.skip("subscription – minimumPlanFor", () => {
  it("returns free for maxPlans (available on all plans)", () => {
    expect(minimumPlanFor("maxPlans")).toBe("free");
  });

  it("returns plus for premiumScenarios", () => {
    expect(minimumPlanFor("premiumScenarios")).toBe("plus");
  });

  it("returns plus for exportPDF", () => {
    expect(minimumPlanFor("exportPDF")).toBe("plus");
  });

  it("returns pro for prioritySupport", () => {
    expect(minimumPlanFor("prioritySupport")).toBe("pro");
  });

  it("returns plus for customThemes", () => {
    expect(minimumPlanFor("customThemes")).toBe("plus");
  });
});
