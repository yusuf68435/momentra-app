import { ScrollViewStyleReset } from "expo-router/html";

// This file is web-only and used to configure the root HTML for every
// web page during static rendering.
// The contents of this function only run in Node.js environments and
// do not have access to the DOM or browser APIs.
export default function Root({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <head>
        <meta charSet="utf-8" />
        <meta httpEquiv="X-UA-Compatible" content="IE=edge" />
        <meta
          name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no"
        />

        {/* SEO Meta Tags */}
        <title>Momentra — Plan Amazing Surprises</title>
        <meta
          name="description"
          content="Momentra helps you plan unforgettable surprises for your loved ones. Discover AI-powered scenarios for birthdays, proposals, anniversaries, and more."
        />
        <meta name="robots" content="index, follow" />
        <meta name="theme-color" content="#FF2D55" />
        <link rel="canonical" href="https://momentra.app" />

        {/* Open Graph */}
        <meta property="og:title" content="Momentra — Plan Amazing Surprises" />
        <meta
          property="og:description"
          content="Momentra helps you plan unforgettable surprises for your loved ones. Discover AI-powered scenarios for birthdays, proposals, anniversaries, and more."
        />
        <meta property="og:type" content="website" />
        <meta property="og:url" content="https://momentra.app" />
        <meta property="og:image" content="https://momentra.app/og-image.png" />
        <meta property="og:site_name" content="Momentra" />
        <meta property="og:locale" content="tr_TR" />
        <meta property="og:locale:alternate" content="en_US" />

        {/* Twitter Card */}
        <meta name="twitter:card" content="summary_large_image" />
        <meta
          name="twitter:title"
          content="Momentra — Plan Amazing Surprises"
        />
        <meta
          name="twitter:description"
          content="Momentra helps you plan unforgettable surprises for your loved ones. Discover AI-powered scenarios for birthdays, proposals, anniversaries, and more."
        />
        <meta
          name="twitter:image"
          content="https://momentra.app/og-image.png"
        />

        {/* Apple Web App */}
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="apple-mobile-web-app-title" content="Momentra" />
        <meta name="apple-mobile-web-app-status-bar-style" content="default" />

        {/* Hreflang */}
        <link rel="alternate" hrefLang="tr" href="https://momentra.app" />
        <link rel="alternate" hrefLang="en" href="https://momentra.app/en" />
        <link
          rel="alternate"
          hrefLang="x-default"
          href="https://momentra.app"
        />

        {/* PWA Manifest */}
        <link rel="manifest" href="/manifest.json" />

        {/* JSON-LD Structured Data */}
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{
            __html: JSON.stringify({
              "@context": "https://schema.org",
              "@type": "MobileApplication",
              name: "Momentra",
              description:
                "Plan amazing surprises for your loved ones. AI-powered scenarios for birthdays, proposals, anniversaries, and more.",
              applicationCategory: "LifestyleApplication",
              operatingSystem: "iOS, Android",
              offers: {
                "@type": "Offer",
                price: "0",
                priceCurrency: "USD",
              },
              aggregateRating: {
                "@type": "AggregateRating",
                ratingValue: "4.8",
                ratingCount: "1200",
              },
            }),
          }}
        />

        {/*
          Disable body scrolling on web. This makes ScrollView components work closer to how they do on native.
          However, body scrolling is often nice to have for mobile web. If you want to enable it, remove this line.
        */}
        <ScrollViewStyleReset />

        {/* Using raw CSS styles as an escape-hatch to ensure the background color never flickers in dark-mode. */}
        <style dangerouslySetInnerHTML={{ __html: responsiveBackground }} />
        {/* Add any additional <head> elements that you want globally available on web... */}
      </head>
      <body>{children}</body>
    </html>
  );
}

const responsiveBackground = `
body {
  background-color: #fff;
}
@media (prefers-color-scheme: dark) {
  body {
    background-color: #000;
  }
}`;
