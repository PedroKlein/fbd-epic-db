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
  { name: "Achievement Percentage", path: "/queries/achievementPercentage", withParams: true },
];
