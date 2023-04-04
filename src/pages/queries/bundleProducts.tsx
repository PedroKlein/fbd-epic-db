import React, { useState } from "react";
import ResultPage from "../../components/ResultPage";
import useSWR from "swr";
import ResultTable from "../../components/ResultTable";
import { UserLibraryRes } from "../api/queries/userLibrary";
import { BundleProductsRes } from "../api/queries/bundleProducts";

const TableHeader: { [K in keyof BundleProductsRes]: string } = {
  bundle_id: "Bundle ID",
  product_id: "Product ID",
  title: "Product Title",
  type: "Product Type",
};

const BundleProductsPage: React.FC = () => {
  const [bundleId, setBundleId] = useState(13);

  const { data } = useSWR<BundleProductsRes[]>(
    `/api/queries/bundleProducts?bundle_id=${bundleId}`
  );

  return (
    <ResultPage
      title="Bundle Products"
      description="Gets all products within a bundle"
    >
      <div className="flex flex-col gap-4">
        <form>
          <div className="input-container">
            <label htmlFor="bundleId">Bundle ID</label>
            <div className="flex flex-row gap-4">
              <input
                className="w-80"
                type="number"
                id="bundleId"
                name="bundleId"
                value={bundleId}
                onChange={(e) => setBundleId(+e.currentTarget.value)}
                min={13}
                max={15}
                placeholder="Select a bundle id..."
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
