const express = require('express')
const app = express()
const mysql = require('mysql2')
const connection = require('./connection')

app.use(express.json())
app.use(express.urlencoded({ extended: false }))


// get all users
app.get('/users', async (req, res) => {
    connection.query('SELECT * FROM users')
    console.log(await connection.query('SELECT * FROM users'))
    res.json(await connection.query('SELECT * FROM users'))
})

// get all blogpost
app.get('/blogposts', async (req, res) => {
    const blogposts = await connection.query('SELECT * FROM blogposts')
    console.log(blogposts)
    res.json(blogposts)
})

// get blogpost by id
app.get('/blogpost/:id', async (req, res) => {
    let id = req.params.id

    res.json(await connection.query(`SELECT * FROM blogposts WHERE id = ${id}`))
})


// create blog
app.post('/blogpost', async (req, res) => {
    let title = req.body.title
    let content = req.body.content

    if (req.body.username && req.body.userpassword) {

        let userData = await connection.query(`SELECT * FROM users WHERE username = '${req.body.username}' AND userpassword = '${req.body.userpassword}' `)
        let authorID = userData[0].user_id

        if (userData[0].user_id && userData[0].username && userData[0].userpassword) {
            await connection.query(
                `
                    INSERT INTO blogposts(authorID, title, content)
                    VALUES
                    (
                        ${authorID},
                        '${title}',
                        '${content}'
                    )
                     `
            )
            res.json({ authorID, title, content })
        }
        else {
            res.status(200).json(await connection.query(`SELECT * FROM blogposts WHERE id = ${id}`))
        }
    }

    else {
        res.status(401).json({ message: "Unauthorized" })
    }
})

// Update blog by id
app.put('/blogpost', async (req, res) => {
    let id = req.body.id
    let title = req.body.title
    let content = req.body.content

    // console.log(req.body)
    if (req.body.username && req.body.userpassword) {

        let userData = await connection.query(`SELECT * FROM users WHERE username = '${req.body.username}' AND userpassword = '${req.body.userpassword}' `)
        if (userData[0].user_id && userData[0].username && userData[0].userpassword) {
            await connection.query(
                `
                UPDATE blogposts
                SET 
                title = ('${title}'),
                content = ('${content}')
                WHERE id = (${id}) AND authorID = ${userData[0].user_id}
                `
            )
            res.json(await connection.query(`SELECT * FROM blogposts WHERE id = ${id}`))
        }
        else {
            res.status(200).json(await connection.query(`SELECT * FROM blogposts WHERE id = ${id}`))
        }
        // console.log(userData)

    }

    else {
        res.status(401).json({ message: "Unauthorized" })
    }


})

// Delete blog by id
app.delete('/blogpost', async (req, res) => {
    let id = req.body.id
    if (req.body.username && req.body.userpassword) {

        let userData = await connection.query(`SELECT * FROM users WHERE username = '${req.body.username}' AND userpassword = '${req.body.userpassword}' `)
        if (userData[0].user_id && userData[0].username && userData[0].userpassword) {
            await connection.query(
                `
                DELETE FROM blogposts WHERE id = (${id}) AND authorID = ${userData[0].user_id}
                `
            )
            res.json(await connection.query(`SELECT * FROM blogposts WHERE id = ${id}`))
        }
        else {
            res.status(200).json(await connection.query(`SELECT * FROM blogposts WHERE id = ${id}`))
        }
        console.log(userData)


    }

    else {
        res.status(401).json({ message: "Unauthorized" })
    }

})

app.listen(3000, () => {
    console.log('Server is running on port 3000')
})

module.exports = app
