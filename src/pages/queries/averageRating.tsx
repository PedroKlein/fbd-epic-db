import React, { useRef, useState } from "react";
import ResultPage from "../../components/ResultPage";
import useSWR from "swr";
import { AverageRatingRes } from "../api/queries/averageRating";
import ResultTable from "../../components/ResultTable";

const TableHeader: { [K in keyof AverageRatingRes]: string } = {
  game_id: "Game ID",
  product_id: "Product ID",
  title: "Title",
  average: "Average Rating",
};

const AverageRatingPage: React.FC = () => {
  const [rating, setRating] = useState(6);
  const ratingRef = useRef(null);

  const { data } = useSWR<AverageRatingRes[]>(
    `/api/queries/averageRating?rating=${rating}`
  );

  return (
    <ResultPage
      title="Average Rating"
      description="Gets all games with an avarage rating above the selected"
    >
      <div className="flex flex-col gap-4">
        <form>
          <div className="input-container">
            <label htmlFor="rating">Minimum Rating</label>
            <div className="flex flex-row gap-4">
              <input
                className="w-80"
                type="number"
                id="rating"
                name="rating"
                onChange={(e) => setRating(+e.currentTarget.value)}
                min={0}
                max={10}
                placeholder="Select a minimum rating..."
                maxLength={100}
                ref={ratingRef}
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

export default AverageRatingPage;
