import { LightningElement, track, wire } from 'lwc';
import { registerListener, unregisterAllListeners } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';
export default class SupplierMapMarkers extends LightningElement {
    @wire(CurrentPageReference) pageRef;

    @track mapMarkers = [];
    zoomLevel = 10;
    Longitude ;
    Latitude ;
    renderMap =false;

    connectedCallback() {
        registerListener("latitude", this.getLatitude, this);
        registerListener("longitude", this.getLongitude, this);
    }

    disconnectedCallback() {
        unregisterAllListeners(this);
    }
    getLongitude(lon) {
        this.renderMap = true;
        this.Longitude = lon;
        this.mapMethod();
    }

    getLatitude(lat) {
        this.Latitude = lat;
    }

    mapMethod() {
        this.mapMarkers = [{
            location: {
                Latitude: this.Latitude,
                Longitude: this.Longitude
            },
            title: this.Latitude + ', ' + this.Longitude,
        }];

    }
}