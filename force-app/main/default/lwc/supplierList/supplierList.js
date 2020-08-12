import { LightningElement, track, api, wire } from 'lwc';
import getSupplierList from '@salesforce/apex/supplierController.findSuppliers';
import ACCOUNT_BillingCity_FIELD from '@salesforce/schema/Account.BillingCity';
import { CurrentPageReference } from 'lightning/navigation';
import { fireEvent } from 'c/pubsub';
import { getRecord } from 'lightning/uiRecordApi';

export default class SupplierList extends LightningElement {

    @api recordId;
    @track supplierList;
    billingCity;
    renderTable;
    displaySupplier = false;
    displayError = false;
 
    @wire(CurrentPageReference) pageRef;
    /* To get the selected Account Billing city */
    @wire(getRecord, { recordId: '$recordId', fields: [ACCOUNT_BillingCity_FIELD] })
    Account;

    /* Method to get the supplier list */
    getSupplierList(event) {
        if (this.recordId != null) {
            this.billingCity = this.Account.data.fields.BillingCity.value;
        }
        this.displaySupplier = true;

        getSupplierList({ city: this.billingCity })
            .then(result => {
                this.supplierList = result;
                if (this.supplierList.length === 0) {
                    this.displayError = true;
                }
                else {
                    this.renderTable = true;
                }

            }).catch(err => console.log(err));

    }

    mapClick(event) {
        this.sendMapCoordinates(event.currentTarget.dataset.lat, event.currentTarget.dataset.lon);
    }

    sendMapCoordinates(lat, long) {
        fireEvent(this.pageRef, "latitude", lat);
        fireEvent(this.pageRef, "longitude", long);
    }

}