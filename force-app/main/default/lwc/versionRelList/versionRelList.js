import { LightningElement, api, track, wire} from 'lwc'
import { getRecord } from 'lightning/uiRecordApi';
import getDocVersions from '@salesforce/apex/documentVersionController.getDocVersions';
const DOCFIELDS = ['ContentDocument.Title'];
export default class VersionRelList extends LightningElement {
    @api recordId;
    @wire(getRecord, {recordId: '$recordId',DOCFIELDS})
    document;

    @track columns = [{
        label: 'Version',
        fieldName: 'VersionNumber',
        type: 'text',
        sortable: true
    },
    {
        label: 'Title',
        fieldName: 'Title',
        type: 'text',
        sortable: true
    },
    {
        label: 'Document Owner',
        fieldName: 'OwnerName',
        type: 'text',
        sortable: true
    },
    {
        label: 'Version Uploaded By',
        fieldName: 'CreatedByName',
        type: 'text',
        sortable: true
    },
    {
        label: 'Version Modified By',
        fieldName: 'LastModifiedByName',
        type: 'text',
        sortable: true
    },
];
    @track error;
    @track data; 
    @wire(getDocVersions,{docId:'$recordId'})
    wiredVersions({
        error,data
    }) {
        if(data) {
            this.data = data
            console.log(data);
            console.log(JSON.stringify(data, null, '\t'));
        }
        else if (error) {
            console.log(error);
        }
    }
    
}