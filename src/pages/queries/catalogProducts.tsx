import React, { useState } from "react";
import ResultPage from "../../components/ResultPage";
import useSWR from "swr";
import ResultTable from "../../components/ResultTable";
import { UserLibraryRes } from "../api/queries/userLibrary";
import { CatalogProductsRes } from "../api/queries/catalogProducts";

const TableHeader: { [K in keyof CatalogProductsRes]: string } = {
  region_id: "Region ID",
  currency_symbol: "Currency Symbol",
  price: "Price",
  net_price: "Net Price",
  discount: "Discount",
  end_date: "End Discount Date",
  title: "Product Title",
  type: "Product Type",
};

const CatalogProductsPage: React.FC = () => {
  const [userId, setUserId] = useState(1);

  const { data } = useSWR<CatalogProductsRes[]>(
    `/api/queries/catalogProducts?user_id=${userId}`
  );

  console.log(data);

  return (
    <ResultPage
      title="Catalog products"
      description="Gets all products in the catalog for a given user"
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
                max={10}
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

export default CatalogProductsPage;
