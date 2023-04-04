import Head from "next/head";
import React, { ReactNode } from "react";
import ResultTable from "./ResultTable";

type Props = {
  title: string;
  description: string;
  children: ReactNode | ReactNode[];
};

const ResultPage: React.FC<Props> = ({ title, description, children }) => {
  return (
    <>
      <Head>
        <title>{title}</title>
      </Head>

      <main>
        <div className="flex flex-col items-center gap-2 mb-8">
          <h1>{title}</h1>
          <p className="font-light">{description}</p>
        </div>

        {children}
      </main>
    </>
  );
};

export default ResultPage;
