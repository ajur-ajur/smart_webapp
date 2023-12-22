const express = require('express');
const bodyParser = require('body-parser');

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

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})