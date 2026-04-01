// Type declarations for react-native-purchases (RevenueCat)
// This file provides type stubs until the package is installed:
//   npm install react-native-purchases

declare module 'react-native-purchases' {
  export interface PurchasesProduct {
    identifier: string;
    title: string;
    description: string;
    price: number;
    priceString: string;
    currencyCode: string;
  }

  export interface PurchasesPackage {
    identifier: string;
    packageType: string;
    product: PurchasesProduct;
    offeringIdentifier: string;
  }

  export interface PurchasesOffering {
    identifier: string;
    serverDescription: string;
    availablePackages: PurchasesPackage[];
    monthly: PurchasesPackage | null;
    annual: PurchasesPackage | null;
    lifetime: PurchasesPackage | null;
  }

  export interface PurchasesOfferings {
    current: PurchasesOffering | null;
    all: Record<string, PurchasesOffering>;
  }

  export interface EntitlementInfo {
    identifier: string;
    isActive: boolean;
    willRenew: boolean;
    expirationDate: string | null;
    productIdentifier: string;
  }

  export interface EntitlementInfos {
    active: Record<string, EntitlementInfo>;
    all: Record<string, EntitlementInfo>;
  }

  export interface CustomerInfo {
    entitlements: EntitlementInfos;
    activeSubscriptions: string[];
    originalAppUserId: string;
  }

  export interface LogInResult {
    customerInfo: CustomerInfo;
    created: boolean;
  }

  const Purchases: {
    configure(config: { apiKey: string; appUserID?: string }): void;
    getOfferings(): Promise<PurchasesOfferings>;
    purchasePackage(pkg: PurchasesPackage): Promise<{ customerInfo: CustomerInfo }>;
    getCustomerInfo(): Promise<CustomerInfo>;
    restorePurchases(): Promise<CustomerInfo>;
    logIn(userId: string): Promise<LogInResult>;
    logOut(): Promise<CustomerInfo>;
  };

  export default Purchases;
}
