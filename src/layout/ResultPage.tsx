import React, { ReactNode } from "react";

type Props = {
  children: ReactNode | ReactNode[];
};

const ResultPage: React.FC<Props> = ({ children }) => {
  return <main>{children}</main>;
};

export default ResultPage;
