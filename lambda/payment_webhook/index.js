exports.handler = async (event) => {
  const method = event.httpMethod;
  const body = event.body;
  console.log(body, "body");
  console.log(JSON.parse(body), "body parsed");
  if (method === "POST") {
    let parsedBody;
    try {
      parsedBody = JSON.parse(body); 
    } catch {
      parsedBody = body;
    }

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
