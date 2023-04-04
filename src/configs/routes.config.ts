export type Routes = {
  name: string;
  path: string;
  withParams?: boolean;
};

export const ROUTES: Routes[] = [
  { name: "Home", path: "/" },
  { name: "Average Rating", path: "/queries/averageRating", withParams: true },
  { name: "Top Seller", path: "/queries/topSeller" },
];
