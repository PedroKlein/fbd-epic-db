import React, { useState } from "react";
import ResultPage from "../../components/ResultPage";
import useSWR from "swr";
import { AverageRatingRes } from "../api/queries/averageRating";
import ResultTable from "../../components/ResultTable";
import { UserLibraryRes } from "../api/queries/userLibrary";
import axios from "axios";

const TableHeader: { [K in keyof UserLibraryRes]: string } = {
  title: "Title",
  cover_img: "Cover Image URL",
  favourite: "Is Favourite?",
};

const UserLibraryPage: React.FC = () => {
  const [userId, setUserId] = useState(1);
  const [productId, setProductId] = useState(1);

  const { data, mutate } = useSWR<UserLibraryRes[]>(
    `/api/queries/userLibrary?user_id=${userId}`
  );

  async function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    await axios.post("/api/queries/insertPurchase", {
      user_id: userId,
      product_id: productId,
    });
    mutate();
  }

  return (
    <ResultPage
      title="Insert Purchase"
      description="Inserts a purchase to validate the trigger"
    >
      <div className="flex flex-col gap-4">
        <form className="flex flex-row justify-between" onSubmit={handleSubmit}>
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
          <div className="input-container">
            <label htmlFor="productId">Product ID</label>
            <div className="flex flex-row gap-4">
              <input
                className="w-80"
                type="number"
                id="productId"
                name="productId"
                value={productId}
                onChange={(e) => setProductId(+e.currentTarget.value)}
                min={1}
                max={15}
                placeholder="Select a product id..."
                required
              />
            </div>
          </div>
          <input
            className="button-fill bg-green-700 cursor-pointer"
            type="submit"
            value="Purchase"
          />
        </form>
        {data && <ResultTable data={data} headers={TableHeader} />}
      </div>
    </ResultPage>
  );
};

export default UserLibraryPage;
