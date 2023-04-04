import React from "react";
import ResultPage from "../../components/ResultPage";
import useSWR from "swr";
import ResultTable from "../../components/ResultTable";
import { TopSellerRes } from "../api/queries/topSeller";

const TableHeader: { [K in keyof TopSellerRes]: string } = {
  region_id: "Region ID",
  name: "Region Name",
  product_id: "Product Id",
  title: "Product Title",
};

const AverageRatingPage: React.FC = () => {
  const { data } = useSWR<TopSellerRes[]>(`/api/queries/topSeller`);

  return (
    <ResultPage
      title="Top Seller"
      description="Gets the top seller product of each reagion"
    >
      <div className="flex flex-col gap-4">
        {data && <ResultTable data={data} headers={TableHeader} />}
      </div>
    </ResultPage>
  );
};

export default AverageRatingPage;
