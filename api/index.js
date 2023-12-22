const express = require('express');
const bodyParser = require('body-parser');
const fetch = require('node-fetch').default;
const date = require('date-and-time');

const app = express();
const port = 5000;

let identity = {
    'name': '',
    'id': 0,
    'address': {
        'city': '',
        'postal': 0
    }
}

app.use(bodyParser.json());

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.get('/name', (req, res) => {
    res.json({
        identity,
    })
})

app.post('/rename', (req, res)=>{
    identity = req.body.identity;
    res.json({
        identity
    })
})

app.post('/transaction', async (req, res)=>{
    url = 'https://app.sandbox.midtrans.com/snap/v1/transactions';
    server_key = 'SB-Mid-server-KAV8I7fp2LZlDOEV9gM1Sy7q';

    const now = new Date();
    date.format(now, 'YYMMDDHHmm');

    AUTH_STRING = Buffer.from(server_key+':').toString('base64');
    
    const headers = {
        'Accept':'application/json',
        'Content-Type':'application/json',
        'Authorization': 'Basic ' + AUTH_STRING,
    };

    const body = {
        'transaction_details': {
            'order_id': now,
            'gross_amount': 200000,
        }
    };

    try{
        const midtransResponse = await fetch(url,{
            method: 'POST',
            headers: headers,
            body: JSON.stringify(body),
        });

        const midtransData = await midtransResponse.json();
        res.json(midtransData);
    }catch(error){
        console.error('Error calling API:', error);
        res.status(500).json({error: 'Status error'});
    }
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})