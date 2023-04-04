import Head from "next/head";
import useSWR from "swr";

const Home: React.FC = () => {
  const { data } = useSWR("/api/hello");
  return (
    <>
      <Head>
        <title>Epic DB</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <div>
        <h1 className="text-default">Test</h1>
      </div>
    </>
  );
};

export default Home;
