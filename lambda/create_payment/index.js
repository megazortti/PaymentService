exports.handler = async () => {
  return {
    statusCode: 200,
    body: `Hello, world!! ${new Date().toISOString()}`
  };
};