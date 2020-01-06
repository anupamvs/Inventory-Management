from myapp import db
import datetime


class Product(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    description = db.Column(db.String(), nullable=True)

    def __repr__(self):
        return '<Product %r>' % self.name


class Location(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    description = db.Column(db.String(), nullable=True)

    def __repr__(self):
        return '<Location %r>' % self.name


class ProductMovement(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    quantity = db.Column(db.Integer, nullable=False)
    product_id = db.Column(db.Integer, db.ForeignKey('product.id'), nullable=False)
    timestamp = db.Column(db.DateTime, default=datetime.datetime.now())
    from_location_id = db.Column(db.Integer, db.ForeignKey('location.id'), nullable=True, default=None)
    to_location_id = db.Column(db.Integer, db.ForeignKey('location.id'), nullable=True, default=None)
    from_location = db.relationship("Location", foreign_keys=[from_location_id])
    to_location = db.relationship("Location", foreign_keys=[to_location_id])
    product = db.relationship("Product", foreign_keys=[product_id])


class Products(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    product_id = db.Column(db.Integer, db.ForeignKey('product.id'), nullable=False)
    location_id = db.Column(db.Integer, db.ForeignKey('location.id'), nullable=False)
    quantity = db.Column(db.Integer, nullable=False)
    timestamp = db.Column(db.DateTime, default=datetime.datetime.now())
    product = db.relationship("Product", foreign_keys=[product_id])
    location = db.relationship("Location", foreign_keys=[location_id])


class User(db.Model):
    __tablename__ = "users"
    id = db.Column('user_id', db.Integer, primary_key=True)
    name = db.Column('name', db.String(30))
    password = db.Column('password', db.String(50))
    email = db.Column('email', db.String(50), unique=True, index=True)
    registered_on = db.Column('registered_on', db.DateTime)

    def __init__(self, name, password, email):
        self.name = name
        self.password = password
        self.email = email
        self.registered_on = datetime.datetime.now()

    def is_authenticated(self):
        return True

    def is_active(self):
        return True

    def is_anonymous(self):
        return False

    def get_id(self):
        return self.id



    def __repr__(self):
        return '<User %r>' % (self.name)


