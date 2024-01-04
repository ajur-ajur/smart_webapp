// DON'T FORGET TO ADD YOUR OWN KEYS
import { merchant_id, client_key, server_key } from './keys.js';

// import {express} from 'express';
// import {bodyParser} from 'body-parser';
// import {date} from 'date-and-time';

import express from 'express';
import bodyParser from 'body-parser';
import date from 'date-and-time';
import midtransClient from 'midtrans-client';
import axios from 'axios';

const snap = new midtransClient.Snap({
    isProduction : false,
    serverKey : server_key,
});

const app = express();
const port = 5000;

const AUTH_STRING = btoa(server_key);
const now = new Date();
date.format(now, 'YYMMDDHHmm');

app.listen(port, () => {
    console.log(`Listening on ${port}`)
  })

const headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': `Basic ${AUTH_STRING}`,
}

let transsactionDetails = {
    'transaction_details':{
        'order_id': '',
        'gross_ammount': 0
    },
    'customer_details':{
        'first_name': '',
        'last_name': '',
        'email': '',
        'phone': '',
        'address': '',
        'postal_code': 0,
        'city': ''
    }
}

app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET, POST');
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
    next();
});

app.use(bodyParser.json());

app.get('/', (req, res) => {
  res.json({
    'Hello': 'World',
  })
})

app.get('/transaction/tests', (req, res) =>{
    res.json({
        'headers':{
            headers,
        },
        'details':{
            transsactionDetails,
        }
    });
})

app.post('/transaction', (req, res) => {
    const endPoint = 'https://app.sandbox.midtrans.com/snap/v1/transactions';
    const requiredFields = ['order_id', 'gross_amount', 'first_name', 'last_name', 'email', 'phone', 'address', 'postal_code', 'city'];

    const missingFields = requiredFields.filter(field => !req.body[field]);
    let transactionToken;

    if (missingFields.length === 0) {
        const transactionDetails = {
            'transaction_details': {
                'order_id': req.body.order_id,
                'gross_amount': req.body.gross_amount
            },
            'customer_details': {
                'first_name': req.body.first_name,
                'last_name': req.body.last_name,
                'email': req.body.email,
                'phone': req.body.phone,
                'address': req.body.address,
                'postal_code': req.body.postal_code,
                'city': req.body.city
            }
        };

        snap.createTransaction(transactionDetails).then((transaction) => {
            transactionToken = transaction.token;
            console.log('transactionToken:', transactionToken);

            res.json({
                'status': 'success',
                'message': 'Transaction details received successfully',
                'data': transactionDetails,
                'token': transactionToken,
            });
        }).catch((error) => {
            console.error('Error creating transaction:', error);

            res.status(500).json({
                'status': 'error',
                'message': 'Internal server error',
            });
        });
    } else {
        res.status(400).json({
            'status': 'error',
            'message': `Incomplete data. Missing fields: ${missingFields.join(', ')}.`
        });
    }
});

app.post('/status', async (req, res) => {
    try {
      const ORDER_ID = req.body.order_id; // Assuming order_id is sent in the request body
  
      const apiUrl = `https://api.sandbox.midtrans.com/v2/${ORDER_ID}/status`;
  
      const headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': `Basic ${AUTH_STRING}`,
      };
  
      const response = await axios.get(apiUrl, { headers });
  
      // Send the transaction status in the response
      res.json({ status: response.data });
    } catch (error) {
      // Handle errors and send an error response
      console.error('Error:', error.message);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  });