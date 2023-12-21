const express = require('express');
const cors = require('cors');
const midtransClient = require('midtrans-client');

const app = express();
const port = 8080;

const SERVER_KEY = 'SB-Mid-server-KAV8I7fp2LZlDOEV9gM1Sy7q';
const CLIENT_KEY = 'SB-Mid-client-56EI2e8pAm4ne06b';

// Enable CORS
app.use(cors());

// Create Snap API instance
let snap = new midtransClient.Snap({
    isProduction: false,
    serverKey: SERVER_KEY,
    clientKey: CLIENT_KEY
});

let server;

app.get('/createTransaction', (req, res) => {
  const orderId = req.query['order_id'];
  const grossAmount = req.query['gross_amount'];

    let parameter = {
        "transaction_details": {
            "order_id": orderId,
            "gross_amount": grossAmount
        },
        "credit_card": {
            "secure": true
        }
    };

    snap.createTransaction(parameter)
        .then((transaction) => {
            // transaction redirect_url
            let redirectUrl = transaction.redirect_url;
            console.log('redirectUrl:', redirectUrl);
            res.json({ redirectUrl });
        })
        .catch((err) => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
});

app.post('/stopServer', (req, res) => {
  res.json({ message: 'Server will be stopped shortly.' });
  server.close(() => {
      console.log('Server has stopped.');
  });
});

server = app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});
