import React, { useState } from "react";
import ResultPage from "../../components/ResultPage";
import useSWR from "swr";
import { AverageRatingRes } from "../api/queries/averageRating";
import ResultTable from "../../components/ResultTable";
import { UserLibraryRes } from "../api/queries/userLibrary";
import { AchievementPercentageRes } from "../api/queries/achievementPercentage";

const TableHeader: { [K in keyof AchievementPercentageRes]: string } = {
  name: "Achievement Name",
  percentage: "Percentage of users",
};

const AchievementPercentagePage: React.FC = () => {
  const [gameId, setGameId] = useState(1);

  const { data } = useSWR<AchievementPercentageRes[]>(
    `/api/queries/achievementPercentage?game_id=${gameId}`
  );

  return (
    <ResultPage
      title="Achievement Percentage"
      description="Gets the percetage of users that completed each achievement from a game"
    >
      <div className="flex flex-col gap-4">
        <form>
          <div className="input-container">
            <label htmlFor="gameId">Game ID</label>
            <div className="flex flex-row gap-4">
              <input
                className="w-80"
                type="number"
                id="gameId"
                name="gameId"
                value={gameId}
                onChange={(e) => setGameId(+e.currentTarget.value)}
                min={0}
                max={10}
                placeholder="Select a game id..."
                required
              />
              {/* <button className="button-fill bg-primary" role="submit">
                Update
              </button> */}
            </div>
          </div>
        </form>
        {data && <ResultTable data={data} headers={TableHeader} />}
      </div>
    </ResultPage>
  );
};

export default AchievementPercentagePage;
