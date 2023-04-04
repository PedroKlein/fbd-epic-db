export interface Region {
  region_id: number;
  currency_symbol: string;
  currency_name: string;
  name: string;
}

export interface User {
  user_id: number;
  email: string;
  nickname: string;
  password: string;
  region_id: number;
}

export type RefundType = 'REFUNDABLE' | 'SELF_REFUNDABLE' | 'NON_REFUNDABLE';

export type ProductType = 'GAME' | 'ADDON' | 'DEMO' | 'EDITION' | 'BUNDLE';

export interface Product {
  product_id: number;
  release_date: string;
  initial_release_date?: string;
  cover_img: string;
  refund_type: RefundType;
  description: string;
  title: string;
  type: ProductType;
}

export type MediaType = 'IMAGE' | 'VIDEO';

export interface Media {
  media_order: number;
  product_id: number;
  url: string;
  media_type: MediaType;
}

export interface Discount {
  percentage: number;
  start_date: string;
  end_date: string;
}

export type DiscountDomain = Discount | null;

export interface Price {
  region_id: number;
  product_id: number;
  price: number;
  discount: DiscountDomain;
}

export interface Wishlist {
  user_id: number;
  product_id: number;
}

export interface Purchase {
  user_id: number;
  product_id: number;
  purchase_date: string;
}

export interface Bundle {
  product_id: number;
}

export interface Package {
  product_id: number;
  bundle_id: number;
}

export interface Game {
  game_id: number;
  product_id: number;
  developer: string;
  publisher: string;
  social_newtworks: string[];
  laucher_name?: string;
  languages: string[];
}

export interface Review {
  user_id: number;
  game_id: number;
  rating: number;
}

export interface Library {
  user_id: number;
  game_id: number;
  favourite: boolean;
}

export interface Genre {
  genre_id: number;
  name: string;
}

export interface Category {
  genre_id: number;
  game_id: number;
}

export interface Feature {
  feature_id: number;
  name: string;
}

export interface Classification {
  feature_id: number;
  game_id: number;
}

export type AchievementCategory = 'GOLD' | 'SILVER' | 'BRONZE';

export interface Achievement {
  name: string;
  game_id: number;
  description: string;
  xp: number;
  category: AchievementCategory;
}

export interface Trophy {
  user_id: number;
  game_id: number;
  name: string;
}

export type AddonType = 'BOOK' | 'GAME_ADDON' | 'SOUNDTRACK' | 'VIDEO';

export interface Addon {
  product_id: number;
  addon_type: AddonType;
  game_id: number;
}

export interface Demo {
  product_id: number;
  duration?: string;
  game_id: number;
}

export interface Edition {
  product_id: number;
  edition_type: string;
  game_id: number;
}
