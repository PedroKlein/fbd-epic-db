import Head from "next/head";
import useSWR from "swr";
import { AverageRatingRes } from "./api/queries/averageRating";

const Home: React.FC = () => {
  const { data } = useSWR<AverageRatingRes[]>("/api/queries/ratingGame?rating=6");
  console.log(data);

  return (
    <>
      <Head>
        <title>Epic DB</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main className="justify-center items-center gap-4">
        <h1 className="text-default">Welcome to Epic DB</h1>

        <h2>Please select your query on the side menu</h2>
      </main>
    </>
  );
};

export default Home;
