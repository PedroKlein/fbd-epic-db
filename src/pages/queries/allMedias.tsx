import React from "react";
import ResultPage from "../../components/ResultPage";
import useSWR from "swr";
import ResultTable from "../../components/ResultTable";
import { TopSellerRes } from "../api/queries/topSeller";
import { AllMediasRes } from "../api/queries/allMedias";

const TableHeader: { [K in keyof AllMediasRes]: string } = {
  game_id: "Game ID",
  product_id: "Product ID",
  url: "Media URL",
};

const TopSellerPage: React.FC = () => {
  const { data } = useSWR<AllMediasRes[]>(`/api/queries/allMedias`);

  return (
    <ResultPage title="All Medias" description="Gets all medias from all games">
      <div className="flex flex-col gap-4">
        {data && <ResultTable data={data} headers={TableHeader} />}
      </div>
    </ResultPage>
  );
};

export default TopSellerPage;
