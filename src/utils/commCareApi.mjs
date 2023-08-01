import axios from "axios";

const fetchImage = async (url) => {
  try {
    // fetch from url with authorization
    const response = await axios.get(url, {
      headers: {
        Authorization: `ApiKey ${process.env.COMMCARE_API_KEY}`,
      },
    });

    const resText = await response.data;
    // encode the response to base64
    const base64encodedData = base64encode(resText);

    // Send the base64 data to the frontend
    return base64encodedData;
  } catch (error) {
    return null;
  }
};

function base64encode(str) {
  let encoded = new Buffer.from(str).toString("base64");
  return encoded;
}

export default fetchImage;
