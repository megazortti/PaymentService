const express = require('express');
const { MercadoPagoConfig, Payment } = require('mercadopago');

const app = express();
const port = 3000;

const client = new MercadoPagoConfig({
  accessToken: 'TEST-6975268641056478-071318-ade95bfd0c357fa900a5f183cacd9278-266642394',
});

const payment = new Payment(client);

app.get('/create-pix', async (req, res) => {
  try {
    const payment_data = {
      transaction_amount: 12.34,
      description: 'Reembolso do Victor 😎',
      payment_method_id: 'pix',
      notification_url: 'https://a9f42f5bac53.ngrok-free.app/webhook',
      payer: {
        email: 'seu.email@dominio.com',
        first_name: 'Victor',
        last_name: 'Mazzotti',
      },
    };

    const response = await payment.create({ body: payment_data });
    console.dir(response, { depth: null, colors: true });;
    const qrCodeData = response.point_of_interaction.transaction_data.qr_code;
    const qrCodeBase64 = response.point_of_interaction.transaction_data.qr_code_base64;

    // Gerar QR Code em formato SVG (opcional)
    // const qrSVG = await QRCode.toString(qrCodeData, { type: 'svg' });

    res.send(`
      <h1>Pagamento PIX Criado</h1>
      <p><strong>Código PIX:</strong></p>
      <textarea rows="5" cols="50" readonly>${qrCodeData}</textarea>
      <p><strong>QR Code:</strong></p>
      <img src="data:image/png;base64,${qrCodeBase64}" />
      <p><button onclick="navigator.clipboard.writeText('${qrCodeData}')">Copiar Código PIX</button></p>
    `);

  } catch (error) {
    console.error('Erro ao criar pagamento:', error);
    res.status(500).send('Erro ao criar pagamento');
  }
});

app.post('/webhook', express.json(), (req, res) => {
  console.log('🔥 Webhook recebido!');
  console.dir(req.body, { depth: null, colors: true });
  res.sendStatus(200);
});


app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
  console.log(`Acesse http://localhost:${port}/create-pix para gerar o PIX`);
});
