import React, { useState } from "react";
import ResultPage from "../../components/ResultPage";
import useSWR from "swr";
import ResultTable from "../../components/ResultTable";
import { GameCompleteRes } from "../api/queries/gameComplete";
import { PriceProductsRes } from "../api/queries/priceProducts";

const TableHeader: { [K in keyof PriceProductsRes]: string } = {
  region_id: "Region ID",
  product_id: "Product ID",
  product_title: "Product Title",
  region_name: "Region Name",
  price: "Price",
};

const BundleProductsPage: React.FC = () => {
  const [price, setPrice] = useState(40);
  const [regionId, setRegionId] = useState(1);

  const { data } = useSWR<PriceProductsRes[]>(
    `/api/queries/priceProducts?price=${price}&region_id=${regionId}`
  );

  return (
    <ResultPage
      title="Price Products"
      description="Gets all products that are above a certain price from a region"
    >
      <div className="flex flex-col gap-4">
        <form className="flex flex-row justify-between">
          <div className="input-container">
            <label htmlFor="price">Min Price</label>
            <div className="flex flex-row gap-4">
              <input
                className="w-80"
                type="number"
                id="price"
                name="price"
                value={price}
                onChange={(e) => setPrice(+e.currentTarget.value)}
                min={0}
                max={200}
                placeholder="Select a price"
                required
              />
            </div>
          </div>

          <div className="input-container">
            <label htmlFor="regionId">Region ID</label>
            <div className="flex flex-row gap-4">
              <input
                className="w-80"
                type="number"
                id="regionId"
                name="regionId"
                value={regionId}
                onChange={(e) => setRegionId(+e.currentTarget.value)}
                min={1}
                max={3}
                placeholder="Select a region id"
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
