#![no_std]
use gtk::{Application, ApplicationWindow, Button, Label, Box, Orientation};
use gtk::prelude::*;
use rand::random;



fn main() {
    let app = Application::builder()
        .application_id("space.mrtuxa.rustyapp")
        .build();

    app.connect_activate(build_ui);
    app.run();
}

fn build_ui(app: &Application) {
    let label = Label::builder()
        .label("Press flip coin to begin")
        .margin_top(12)
        .margin_bottom(12)
        .margin_start(12)
        .margin_end(12)
        .build();

    let button = Button::builder()
        .label("Flip coin")
        .margin_top(12)
        .margin_bottom(12)
        .margin_start(12)
        .margin_end(12)
        .build();

    let content = Box::new(Orientation::Vertical, 0);

    content.append(&label);
    content.append(&button);


    button.connect_clicked(move |_| flip_coin(&label));

    let window = ApplicationWindow::builder()
        .title("Rusty App")
        .application(app)
        .child(&content)
        .build();

    window.show();
}

fn flip_coin(label: &Label) {
    if random() {
        label.set_text("Heads");
    } else {
        label.set_text("Tails");
    }
}