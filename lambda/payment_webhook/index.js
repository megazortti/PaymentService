const AWS = require("aws-sdk");
const ses = new AWS.SES();
const ssm = new AWS.SSM();

const getToken = async () => {
  const param = await ssm.getParameter({
    Name: "/secrets/mercadopago/pix_token",
    WithDecryption: true
  }).promise();

  return param.Parameter.Value;
};

exports.handler = async (event) => {
  const method =
    event.httpMethod || (event.requestContext && event.requestContext.http && event.requestContext.http.method);

  if (method !== "POST") {
    return {
      statusCode: 405,
      body: JSON.stringify({
        error: "Método não permitido",
        timestamp: new Date().toISOString(),
      }),
    };
  }

  let parsedBody;
  try {
    parsedBody = JSON.parse(event.body);
  } catch {
    parsedBody = {};
  }

  const params = {
    Source: "pay@mazzotti.app",
    Destination: {
      ToAddresses: ["mazzotti.vlm@gmail.com"],
    },
    Message: {
      Subject: { Data: "Novo POST recebido - SES Sandbox" },
      Body: {
        Text: {
          Data: `Você recebeu um POST com os dados:\n\n${JSON.stringify(parsedBody, null, 2)}. TOKEN: ${await getToken().slice(0, -5)}`,
        },
      },
    },
  };

  try {
    await ses.sendEmail(params).promise();

    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "Email enviado com sucesso!",
        data: parsedBody,
        timestamp: new Date().toISOString(),
      }),
    };
  } catch (err) {
    console.error("Erro ao enviar email:", err);

    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Falha ao enviar email." }),
    };
  }
};
