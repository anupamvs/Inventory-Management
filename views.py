from myapp import app, db, login_manager
from flask import render_template, request, redirect, url_for, flash
from models import *
import json
from flask_login import login_user, logout_user, current_user, login_required
import hashlib


with open("config.json") as temp:
    config = json.load(temp)

@app.route('/')
@login_required
def home():
    print(current_user)
    return render_template('index.html', config=config)

@app.route('/productmovements/')
@app.route('/productmovements/<int:page>')
@login_required
def product_movements(page=1):
    movements = ProductMovement.query.order_by(ProductMovement.timestamp.desc()).paginate(page, config['GLOBAL']['page_limit'], error_out=False)

    return render_template('movement/productmovements.html', config=config, movements=movements)


@app.route('/productmovement/new/', methods=["GET", "POST"])
@login_required
def new_movement():

    (from_location, to_location, product, quantity) = ("", "", "", "")
    if request.method == "POST":
        from_location = int(request.form.get("from", ""))
        to_location = int(request.form.get("to", ""))
        product = request.form.get("product", "")
        quantity = request.form.get("quantity", 0)
        if not from_location and not to_location:
            flash(u'From and To can not be empty at same time.', 'error')
        elif not product:
            flash(u'Select a product.', 'error')
        elif not quantity:
            flash(u'Quantity must be numeric and not empty.', 'error')
        elif from_location == to_location:
            flash(u'From and To can not be same.', 'error')
        else:
            quantity = int(quantity)

            if not from_location:
                from_location = None
            if not to_location:
                to_location = None

            if to_location and not from_location:
                product_location = db.session.query(Products).filter_by(location_id=to_location, product_id=product).first()
                if not product_location :
                    product_location = Products(location_id=to_location, product_id=product, quantity=quantity)
                    db.session.add(product_location)
                else:
                    product_location.quantity += quantity
                flash(u'Movement Successful.', 'success')
            elif from_location and not to_location:
                product_location = db.session.query(Products).filter_by(location_id=from_location, product_id=product).first()
                if not product_location :
                    flash(u'The selected product is not available at this location.', 'warning')
                    return redirect(url_for('new_movement'))

                else:
                    if product_location.quantity < quantity:
                        flash(u'Quantity is more than available.', 'error')
                        return redirect(url_for('new_movement'))

                    product_location.quantity -= quantity
                    flash(u'Movement Successful.', 'success')
            else:
                source_location = db.session.query(Products).filter_by(location_id=from_location,
                                                                        product_id=product).first()
                if not source_location:
                    flash(u'The selected product is not available at this location.', 'warning')
                    return redirect(url_for('new_movement'))

                else:
                    if source_location.quantity < quantity:
                        flash(u'Quantity is more than available.', 'error')
                        return redirect(url_for('new_movement'))
                    dest_location = db.session.query(Products).filter_by(location_id=to_location,
                                                                            product_id=product).first()
                    if not dest_location:
                        dest_location = Products(location_id=to_location, product_id=product, quantity=quantity)
                        db.session.add(dest_location)
                    else:
                        source_location.quantity -= quantity
                        dest_location.quantity += quantity
                    flash(u'Movement Successful.', 'success')

           # elif to_location and not from_location:



            movement = ProductMovement(from_location_id=from_location, to_location_id=to_location, product_id=product,
                                       quantity=quantity)
            db.session.add(movement)
            db.session.commit()

    products = Product.query.all()
    locations = Location.query.all()
    return render_template('movement/movement.html', config=config, products=products, locations=locations)


# Start Product Route

@app.route('/product/new/', methods=["GET", "POST"])
@login_required
def add_product():
    if request.method == "POST":
        name = request.form.get('product_name')
        description = request.form.get('product_description')

        product = Product(name=name, description=description)
        db.session.add(product)
        db.session.commit()
        flash(u'Product Added.', 'success')
    return render_template('product/form.html', config=config)


@app.route('/product/<int:pid>', methods=["GET", "POST"])
@login_required
def edit_product(pid):
    product = Product.query.get(pid)
    if request.method == "POST":
        name = request.form.get('product_name')
        description = request.form.get('product_description')

        product.name = name
        product.description = description

        db.session.commit()
        flash(u'Product Updated.', 'success')
    return render_template('product/edit.html', config=config, product=product)


@app.route('/product/delete/<int:pid>')
@login_required
def delete_product(pid):
    product = Product.query.get(pid)
    db.session.delete(product)
    db.session.commit()

    return redirect(url_for('view_products'))


@app.route('/products/')
@app.route('/products/<int:page>')
@login_required
def view_products(page=1):
    products = Product.query.paginate(page, config['GLOBAL']['page_limit'], error_out=False)

    return render_template('product/products.html', config=config, products = products)



@app.route('/products/balance/')
@login_required
def product_balance():
    product_balance = Products.query.all()

    return render_template('product/balance.html', config=config, product_balance=product_balance)
# End Product Routing

# Start Location Routing


@app.route('/location/new/', methods=["GET", "POST"])
@login_required
def add_location():
    if request.method == "POST":
        name = request.form.get('location_name')
        description = request.form.get('location_description')

        location = Location(name=name, description=description)
        db.session.add(location)
        db.session.commit()
        flash(u'Location Added.', 'success')
    return render_template('location/form.html', config=config)


@app.route('/location/<int:lid>', methods=["GET", "POST"])
@login_required
def edit_location(lid):
    location = Location.query.get(lid)
    if request.method == "POST":
        name = request.form.get('location_name')
        description = request.form.get('location_description')

        location.name = name
        location.description = description

        db.session.commit()
        flash(u'Location Updated.', 'success')
    return render_template('location/edit.html', config=config, location=location)


@app.route('/location/delete/<int:lid>')
@login_required
def delete_location(lid):
    location = Location.query.get(lid)
    db.session.delete(location)
    db.session.commit()

    return redirect(url_for('view_locations'))


@app.route('/locations/')
@app.route('/locations/<int:page>')
@login_required
def view_locations(page=1):
    locations = Location.query.paginate(page, config['GLOBAL']['page_limit'], error_out=False)
    return render_template('location/locations.html', config=config, locations=locations)


# End Location Routing


@app.route('/register/', methods=['GET', 'POST'])
def register():
    if request.method == 'GET':
        return render_template('user/register.html', config=config)
    password = request.form.get('password')
    password = (hashlib.md5(password.encode())).hexdigest()
    user = User(request.form.get('name'), password, request.form.get('email'))
    db.session.add(user)
    db.session.commit()
    flash('User successfully registered', 'success')
    return redirect(url_for('login'))


@app.route('/login/', methods=['GET', 'POST'])
def login():
    if request.method == 'GET':
        return render_template('user/login.html')
    email = request.form.get('email')
    password = request.form.get('password')
    password = (hashlib.md5(password.encode())).hexdigest()
    registered_user = User.query.filter_by(email=email, password=password).first()
    if registered_user is None:
        flash('Email or Password is invalid', 'error')
        return redirect(url_for('login'))
    login_user(registered_user)
    flash('Logged in successfully', 'success')
    return redirect(request.args.get('next') or url_for('home'))


@app.route('/logout')
def logout():
    logout_user()
    flash('Logout successfully', 'success')
    return redirect(url_for('login'))

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(user_id)