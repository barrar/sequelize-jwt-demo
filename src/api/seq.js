const { Sequelize, DataTypes } = require('sequelize');
const bcrypt = require("bcrypt");

global.seq =  new Sequelize(process.env.MYSQL_DATABASE, process.env.MYSQL_USER, process.env.MYSQL_PASSWORD, {
    host: process.env.MYSQL_HOSTNAME,
    port: process.env.MYSQL_PORT,
    dialect: 'mysql',
    define: {
        freezeTableName: true,
        timestamps: false
    }
})

global.seqBusiness = seq.define('business', {
    name: { type: DataTypes.STRING, allowNull: false },
    address: { type: DataTypes.STRING, allowNull: false },
    city: { type: DataTypes.STRING, allowNull: false },
    state: { type: DataTypes.STRING, allowNull: false },
    zip: { type: DataTypes.INTEGER, allowNull: false },
    phone: { type: DataTypes.STRING, allowNull: false },
    // Perhaps use https://sequelize.org/master/manual/getters-setters-virtuals.html
    // To store phone number as integer...
    category: { type: DataTypes.STRING, allowNull: false },
    subcategory: { type: DataTypes.STRING, allowNull: false },
    website: { type: DataTypes.STRING, allowNull: true },
    email: { type: DataTypes.STRING, allowNull: true }
})

global.seqPhoto = seq.define('photo', {
    caption: { type: DataTypes.STRING, allowNull: true }
})

global.seqReview = seq.define('review', {
    dollars: { type: DataTypes.INTEGER, allowNull: false },
    stars: { type: DataTypes.INTEGER, allowNull: false },
    review: { type: DataTypes.STRING, allowNull: true }
})

global.seqUser = seq.define('user', {
    name: { type: DataTypes.STRING, allowNull: false },
    email: { type: DataTypes.STRING, allowNull: false },
    password: {
        type: DataTypes.STRING,
        allowNull: false,
        set(password) { // The password is hashed before storage
            this.setDataValue('password', bcrypt.hashSync(password, 10));
        }
    },
    admin: { type: DataTypes.BOOLEAN, allowNull: false },
},
{
    defaultScope: {
        attributes: { exclude: ['password'] },
    },
    scopes: {
        includePassword: {}
      }
})

seqUser.prototype.checkPassword = function (password) {
    return bcrypt.compare(password, this.password)
}

seqUser.hasMany(seqBusiness, { foreignKey: { name: 'ownerid', allowNull: false } })
seqUser.hasMany(seqReview, { foreignKey: { name: 'userid', allowNull: false } })
seqUser.hasMany(seqPhoto, { foreignKey: { name: 'userid', allowNull: false } })

seqBusiness.hasMany(seqReview, { foreignKey: { name: 'businessid', allowNull: false } })
seqBusiness.hasMany(seqPhoto, { foreignKey: { name: 'businessid', allowNull: false } })

// seq.sync({ alter: true})

// async function putData() {
//     for (i = 0; i < 50; i++){
//         await seqUser.create({
//             name: "admin" + i,
//             email: "admin" + i + "@example.com",
//             password: "asdfg",
//             admin: true
//         });
//     }
//     for (i = 0; i < 50; i++){
//         await seqUser.create({
//             name: "user" + i,
//             email: "user" + i + "@example.com",
//             password: "asdfg",
//             admin: false
//         });
//     }
// }

// putData()