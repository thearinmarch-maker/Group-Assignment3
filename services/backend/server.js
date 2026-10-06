const express = require('express');
const os = require('os');
const app = express();
const PORT = 5000;

app.get('/api/health', (req, res) => {
    res.json({
        status: 'UP',
        message: 'Backend operational',
        container: os.hostname()
    });
});

app.listen(PORT, () => {
    console.log(Backend server running on port );
});
