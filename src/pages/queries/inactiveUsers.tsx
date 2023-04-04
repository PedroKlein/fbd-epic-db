import React from "react";
import ResultPage from "../../components/ResultPage";
import useSWR from "swr";
import ResultTable from "../../components/ResultTable";
import { TopSellerRes } from "../api/queries/topSeller";
import { InactiveUsersRes } from "../api/queries/inactiveUsers";

const TableHeader: { [K in keyof InactiveUsersRes]: string } = {
  region_id: "Region ID",
  name: "Region Name",
  user_id: "User Id",
  nickname: "User Nickname",
};

const InactiveUsersPage: React.FC = () => {
  const { data } = useSWR<InactiveUsersRes[]>(`/api/queries/inactiveUsers`);

  return (
    <ResultPage
      title="Inactive Users"
      description="Gets all users that didn't bought anything in the last month"
    >
      <div className="flex flex-col gap-4">
        {data && <ResultTable data={data} headers={TableHeader} />}
      </div>
    </ResultPage>
  );
};

export default InactiveUsersPage;
