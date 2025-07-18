exports.handler = async (event) => {
  const method = event.httpMethod; // GET, POST, etc.
  const body = event.body;         // corpo da requisição (em string)

  if (method === "POST") {
    let parsedBody;
    try {
      parsedBody = JSON.parse(body); // tenta parsear o body como JSON
    } catch {
      parsedBody = body; // se não for JSON, retorna como está
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
