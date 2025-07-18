exports.handler = async (event) => {
  const method =
    event.httpMethod || (event.requestContext && event.requestContext.http && event.requestContext.http.method);
  const body = event.body;
  console.log(body, "body");

  let parsedBody;
  try {
    parsedBody = JSON.parse(body);
    console.log(parsedBody, "body parsed");
  } catch {
    parsedBody = body;
  }

  if (method === "POST") {
    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "POST recebido com sucesso!",
        data: parsedBody,
        timestamp: new Date().toISOString(),
      }),
    };
  }

  return {
    statusCode: 405,
    body: JSON.stringify({
      error: "Método não permitido",
      timestamp: new Date().toISOString(),
    }),
  };
};
