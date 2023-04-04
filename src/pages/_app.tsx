import "@/styles/globals.css";
import "@/styles/components.css";
import type { AppProps } from "next/app";

import { Inter } from "next/font/google";
import { SWRConfig } from "swr";
import { SWR_CONFIG } from "../configs/swr.config";

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-inter",
});

export default function App({ Component, pageProps }: AppProps) {
  return (
    <SWRConfig value={SWR_CONFIG}>
      <main className={`${inter.variable} font-sans`}>
        <Component {...pageProps} />
      </main>
    </SWRConfig>
  );
}
