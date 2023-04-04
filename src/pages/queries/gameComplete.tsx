import React, { useState } from "react";
import ResultPage from "../../components/ResultPage";
import useSWR from "swr";
import ResultTable from "../../components/ResultTable";
import { GameCompleteRes } from "../api/queries/gameComplete";

const TableHeader: { [K in keyof GameCompleteRes]: string } = {
  game_id: "Game ID",
  title: "Title",
  developer: "Developer",
  publisher: "Publisher",
  feature_name: "Feature Name",
  genre_name: "Genre Name",
  achievement_name: "Achievement Name",
  os: "OS Name",
};

const BundleProductsPage: React.FC = () => {
  const [gameId, setGameId] = useState(1);

  const { data } = useSWR<GameCompleteRes[]>(
    `/api/queries/gameComplete?game_id=${gameId}`
  );

  return (
    <ResultPage
      title="Game Complete"
      description="Gets all essential information about a game."
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
                min={1}
                max={3}
                placeholder="Select a game id..."
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

export default BundleProductsPage;
