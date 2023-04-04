/** @type {import('tailwindcss').Config} */
const { fontFamily } = require("tailwindcss/defaultTheme");

const generateColorClass = (variable) => {
  return ({ opacityValue }) =>
    opacityValue
      ? `rgba(var(--${variable}), ${opacityValue})`
      : `rgb(var(--${variable}))`;
};

const textColor = {
  default: generateColorClass("text-default"),
  neutral: generateColorClass("text-neutral"),
};

const backgroundColor = {
  default: generateColorClass("bg-default"),
  neutral: generateColorClass("bg-neutral"),
};

module.exports = {
  content: ["./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      textColor,
      backgroundColor,
      colors: {
        primary: generateColorClass("primary-color"),
        secondary: generateColorClass("secondary-color"),
        tertiary: generateColorClass("tertiary-color"),
      },
      fontFamily: {
        sans: ["var(--font-inter)", ...fontFamily.sans],
      },
    },
  },
  darkMode: ["class", '[data-theme="dark"]'],
  plugins: [],
};
