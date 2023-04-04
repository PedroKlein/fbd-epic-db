import React, { useState } from "react";
import ResultPage from "../../components/ResultPage";
import useSWR from "swr";
import ResultTable from "../../components/ResultTable";
import { UserLibraryRes } from "../api/queries/userLibrary";

const TableHeader: { [K in keyof UserLibraryRes]: string } = {
  title: "Title",
  cover_img: "Cover Image URL",
  favourite: "Is Favourite?",
};

const UserLibraryPage: React.FC = () => {
  const [userId, setUserId] = useState(1);

  const { data } = useSWR<UserLibraryRes[]>(
    `/api/queries/userLibrary?user_id=${userId}`
  );

  return (
    <ResultPage
      title="User Library"
      description="Gets all games in a user's library."
    >
      <div className="flex flex-col gap-4">
        <form>
          <div className="input-container">
            <label htmlFor="userId">User ID</label>
            <div className="flex flex-row gap-4">
              <input
                className="w-80"
                type="number"
                id="userId"
                name="userId"
                value={userId}
                onChange={(e) => setUserId(+e.currentTarget.value)}
                min={1}
                max={5}
                placeholder="Select a user id..."
                required
              />
            </div>
          </div>
        </form>
        {data && <ResultTable data={data} headers={TableHeader} />}
      </div>
    </ResultPage>
  );
};

export default UserLibraryPage;
