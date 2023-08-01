const fetchImage = async (url) => {
  try {
    // fetch from url with authorization
    const response = await fetch(url, {
      method: "GET",
      headers: {
        authorization: `ApiKey ${process.env.COMMCARE_API_KEY}`,
      },
    });
    const resText = await response.text();
    // encode the response to base64
    const base64encodedData = base64encode(resText);

    // Send the base64 data to the frontend
    return base64encodedData;
  } catch (error) {
    console.log(error);
    // Handle any errors that might occur during the API call
    return null;
  }
};

function base64encode(str) {
  let encoded = new Buffer.from(str).toString("base64");
  return encoded;
}

export default fetchImage;
