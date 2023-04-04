export type Routes = {
  name: string;
  path: string;
  withParams?: boolean;
};

export const ROUTES: Routes[] = [
  { name: "Home", path: "/" },
  { name: "Average Rating", path: "/queries/averageRating", withParams: true },
  { name: "Top Seller", path: "/queries/topSeller" },
  { name: "Inactive Users", path: "/queries/inactiveUsers" },
  { name: "User Library", path: "/queries/userLibrary", withParams: true },
  {
    name: "Achievement Percentage",
    path: "/queries/achievementPercentage",
    withParams: true,
  },
  {
    name: "Bundle Products",
    path: "/queries/bundleProducts",
    withParams: true,
  },
  { name: "Game Complete", path: "/queries/gameComplete", withParams: true },
  {
    name: "Catalog Products",
    path: "/queries/catalogProducts",
    withParams: true,
  },
  {
    name: "All Medias",
    path: "/queries/allMedias",
  },
  {
    name: "Price Products",
    path: "/queries/priceProducts",
    withParams: true,
  },
];
