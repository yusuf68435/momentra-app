import { getCreditsForPlan } from "../../src/services/credits";

describe("credits – getCreditsForPlan", () => {
  it("returns 5 for free plan", () => {
    expect(getCreditsForPlan("free")).toBe(5);
  });

  it("returns 50 for plus plan", () => {
    expect(getCreditsForPlan("plus")).toBe(50);
  });

  it("returns MAX_SAFE_INTEGER for pro plan", () => {
    expect(getCreditsForPlan("pro")).toBe(Number.MAX_SAFE_INTEGER);
  });
});
