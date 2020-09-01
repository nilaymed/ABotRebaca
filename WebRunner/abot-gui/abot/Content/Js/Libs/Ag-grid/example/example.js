var gridDiv;

document.addEventListener('DOMContentLoaded', function () {
    renderGrid('#myGrid');
});

function renderGrid(placeHolder, cols, data){
    gridDiv = document.querySelector(placeHolder);
    var gridTemplate = createGridDiv();
    $(gridDiv).append(gridTemplate);
    
    new agGrid.Grid(gridDiv, gridOptions);
    
    if (cols === undefined || data === undefined){
        createData();
    }
    else {
        gridOptions.api.setColumnDefs(cols);
        gridOptions.api.setRowData(data);
        eMessage.style.display = 'none';
        eMessageText.innerHTML = '';
    }
}

function createGridDiv(){
    var gridTemplate = "<div style='padding: 4px;'> \
                        <input placeholder='Search...' type='text' \
                            oninput='onFilterChanged(this.value)' \
                            style='color: #333;width:40%' \
                        /> \
                    </div> \
                    <div class='data-grid'></div>"
    return gridTemplate;    
}

var colNames = ["Station", "Railway", "Street", "Address", "Toy", "Soft Box", "Make and Model", "Longest Day", "Shortest Night"];

var countries = [
    {country: "Ireland", continent: "Europe", language: "English"},
    {country: "Spain", continent: "Europe", language: "Spanish"},
    {country: "United Kingdom", continent: "Europe", language: "English"},
    {country: "France", continent: "Europe", language: "French"},
    {country: "Germany", continent: "Europe", language: "German"},
    {country: "Luxembourg", continent: "Europe", language: "French"},
    {country: "Sweden", continent: "Europe", language: "Swedish"},
    {country: "Norway", continent: "Europe", language: "Norwegian"},
    {country: "Italy", continent: "Europe", language: "Italian"},
    {country: "Greece", continent: "Europe", language: "Greek"},
    {country: "Iceland", continent: "Europe", language: "Icelandic"},
    {country: "Portugal", continent: "Europe", language: "Portuguese"},
    {country: "Malta", continent: "Europe", language: "Maltese"},
    {country: "Brazil", continent: "South America", language: "Portuguese"},
    {country: "Argentina", continent: "South America", language: "Spanish"},
    {country: "Colombia", continent: "South America", language: "Spanish"},
    {country: "Peru", continent: "South America", language: "Spanish"},
    {country: "Venezuela", continent: "South America", language: "Spanish"},
    {country: "Uruguay", continent: "South America", language: "Spanish"},
    {country: "Belgium", continent: "Europe", language: "French"}
];

var games = ["Chess", "Cross and Circle", "Daldøs", "Downfall", "DVONN", "Fanorona", "Game of the Generals", "Ghosts",
    "Abalone", "Agon", "Backgammon", "Battleship", "Blockade", "Blood Bowl", "Bul", "Camelot", "Checkers",
    "Go", "Gipf", "Guess Who?", "Hare and Hounds", "Hex", "Hijara", "Isola", "Janggi (Korean Chess)", "Le Jeu de la Guerre",
    "Patolli", "Plateau", "PÜNCT", "Rithmomachy", "Sáhkku", "Senet", "Shogi", "Space Hulk", "Stratego", "Sugoroku",
    "Tâb", "Tablut", "Tantrix", "Wari", "Xiangqi (Chinese chess)", "YINSH", "ZÈRTZ", "Kalah", "Kamisado", "Liu po",
    "Lost Cities", "Mad Gab", "Master Mind", "Nine Men's Morris", "Obsession", "Othello"
];
var booleanValues = [true, "true", false, "false"];

var firstNames = ["Sophie", "Isabelle", "Emily", "Olivia", "Lily", "Chloe", "Isabella",
    "Amelia", "Jessica", "Sophia", "Ava", "Charlotte", "Mia", "Lucy", "Grace", "Ruby",
    "Ella", "Evie", "Freya", "Isla", "Poppy", "Daisy", "Layla"];
var lastNames = ["Beckham", "Black", "Braxton", "Brennan", "Brock", "Bryson", "Cadwell",
    "Cage", "Carson", "Chandler", "Cohen", "Cole", "Corbin", "Dallas", "Dalton", "Dane",
    "Donovan", "Easton", "Fisher", "Fletcher", "Grady", "Greyson", "Griffin", "Gunner",
    "Hayden", "Hudson", "Hunter", "Jacoby", "Jagger", "Jaxon", "Jett", "Kade", "Kane",
    "Keating", "Keegan", "Kingston", "Kobe"];

var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

var dataSize = '.1x22';

var size = 'fill'; // model for size select
var width = '100%'; // the div gets it's width and height from here
var height = '100%';

var rowSelection = 'checkbox';


// the moving animation looks crap on IE, firefox and safari, so we turn it off in the demo for them
function suppressColumnMoveAnimation() {
    var isFirefox = typeof InstallTrigger !== 'undefined';
    // At least Safari 3+: "[object HTMLElementConstructor]"
    var isSafari = Object.prototype.toString.call(window.HTMLElement).indexOf('Constructor') > 0;
    // Internet Explorer 6-11
    var isIE = /*@cc_on!@*/false || !!document.documentMode;

    return isFirefox || isSafari || isIE;
}

var gridOptions = {
    animateRows: true,
    enableColResize: true, //one of [true, false]
    enableSorting: true, //one of [true, false]
    enableFilter: true, //one of [true, false]
    enableStatusBar: true,
    enableRangeSelection: true,
    rowSelection: "", // one of ['single','multiple'], leave blank for no selection
    rowDeselection: true,
    quickFilterText: null,
    showToolPanel: true,//window.innerWidth > 1000,
    icons: {
        //menu: '<i class="fa fa-bars"/>',
        //columnVisible: '<i class="fa fa-eye"/>',
        //columnHidden: '<i class="fa fa-eye-slash"/>',
        columnRemoveFromGroup: '<i class="fa fa-remove"/>',
        filter: '<i class="fa fa-filter"/>',
        sortAscending: '<i class="fa fa-long-arrow-down"/>',
        sortDescending: '<i class="fa fa-long-arrow-up"/>',
        //groupExpanded: '<i class="fa fa-minus-square-o"/>',
        //groupContracted: '<i class="fa fa-plus-square-o"/>',
        //columnGroupOpened: '<i class="fa fa-minus-square-o"/>',
        //columnGroupClosed: '<i class="fa fa-plus-square-o"/>'
    },
    //callback when row clicked
    //onRowClicked: function (params) {
        // console.log("Callback onRowClicked: " + (params.data?params.data.name:null) + " - " + params.event);
    //},
    // onSortChanged: function (params) {
    //     console.log("Callback onSortChanged");
    // },
    // onRowDoubleClicked: function (params) {
        // console.log("Callback onRowDoubleClicked: " + params.data.name + " - " + params.event);
    // },
    // callback when cell clicked
    //onCellClicked: function (params) {
        // console.log("Callback onCellClicked: " + params.value + " - " + params.colDef.field + ' - ' + params.event);
        //alert("Callback onCellClicked: " + params.value + " - " + params.colDef.field + ' - ' + params.event);
    //},
    //onRowDataChanged: function (params) {
    //    console.log('Callback onRowDataChanged: ');
    //},
    // callback when cell double clicked
    onCellDoubleClicked: function (params) {
        // console.log("Callback onCellDoubleClicked: " + params.value + " - " + params.colDef.field + ' - ' + params.event);
        alert("Callback onCellDoubleClicked: " + params.value + " - " + params.colDef.field + ' - ' + params.event);
    },
    // callback when cell right clicked
    //onCellContextMenu: function (params) {
    //    console.log("Callback onCellContextMenu: " + params.value + " - " + params.colDef.field + ' - ' + params.event);
    //},
    //onCellFocused: function (params) {
        // console.log('Callback onCellFocused: ' + params.rowIndex + " - " + params.colIndex);
    //},
    onGridReady: function (event) {
        console.log('Callback onGridReady: api = ' + event.api);
        //event.api.addGlobalListener(function(type, event) {
        //    console.log('event ' + type);
        //});
    }
};

var defaultCols = [
    {
        headerName: 'Name',
        field: 'name',
        width: 200,
        editable: false,
        icons: {
            sortAscending: '<i class="fa fa-sort-asc"/>',
            sortDescending: '<i class="fa fa-sort-desc"/>'
        }
    },
    {
        headerName: "Language", 
        field: "language", 
        width: 150, 
        editable: false, 
        filter: 'set',
        icons: {
            sortAscending: '<i class="fa fa-sort-asc"/>',
            sortDescending: '<i class="fa fa-sort-desc"/>'
        }
    },
    {
        headerName: "Country", 
        field: "country", 
        width: 150, 
        editable: false,
        icons: {
            sortAscending: '<i class="fa fa-sort-asc"/>',
            sortDescending: '<i class="fa fa-sort-desc"/>'
        }
    }
]


/* Theme Selection */

function onThemeChanged(newTheme) {
    gridDiv.className = newTheme;
    if(newTheme === 'ag-material') {
        gridOptions.rowHeight = 48;
        // gridOptions.icons.checkboxChecked = '<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAABmJLR0QAAAAAAAD5Q7t/AAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4AUZEBAL/ldO7gAAAEpJREFUKM9jZJjW8Z+BDMDEQCagrcb/meUM/zPL6WQjzCbG6Z10sBGXbRgasQUCLsCCzyZctmHYiEsRUX5E1ozPIKxOJcZmsqMDAKbtFz19uHD9AAAAAElFTkSuQmCC"/>';
        gridOptions.icons.checkboxChecked = '<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA2ZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDoxMTQzMkY1NDIyMjhFNjExQkVGOEFCQUI5MzdBNjFEMSIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDoyMzBBQkU2ODI4MjQxMUU2QjlDRUZCNUFDREJGRTVDMCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDoyMzBBQkU2NzI4MjQxMUU2QjlDRUZCNUFDREJGRTVDMCIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M2IChXaW5kb3dzKSI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjE0NDMyRjU0MjIyOEU2MTFCRUY4QUJBQjkzN0E2MUQxIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjExNDMyRjU0MjIyOEU2MTFCRUY4QUJBQjkzN0E2MUQxIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+O+zv0gAAAQ1JREFUeNpilJvw35OBgWEuEEsyEAeeA3EyI1DjMxI0wTUzkaEJBCSZiFVpJcvAsDqEgUFVCMInSqOeOAPDLG8GBjNpBoZCCyI1KggwMCzwZ2DgZWdgOPWUgaF4F5pGDxWgqT4MDPzsSB7hYWBYHMDAIMzJwHDjDQND0mYGhu9/0DT6qTEwuCszMOyIZmAwkoTYALJJjp+B4cEHBoaEjQwMn38iDAVFx38wA4gzTBgYSiwhEi++MDDI8DEwvP3OwBC0CqIZGcBtBOmefoaBIXQNA8PvfxBNf4B03AZMTVgD5xwwXcQDFX/8wcAw+RQDw5VX2AMN7lRSARM07ZEKXoA0poAYJGh6CkrkAAEGAKNeQxaS7i+xAAAAAElFTkSuQmCC"/>';
    } else {
        gridOptions.rowHeight = 25;
        gridOptions.icons.checkboxChecked = undefined;
        gridOptions.icons.checkboxIndeterminate = undefined;
    }
    gridOptions.api.resetRowHeights();
    gridOptions.api.refreshRows();
}

/* Top Search */

var filterCount = 0;
function onFilterChanged(newFilter) {
    filterCount++;
    var filterCountCopy = filterCount;
    setTimeout(function () {
        if (filterCount === filterCountCopy) {
            gridOptions.api.setQuickFilter(newFilter);
        }
    }, 300);
}


/* Top Data Generate */

function onDataSizeChanged(newDataSize) {
    dataSize = newDataSize;
    createData();
}

function getColCount() {
    switch (dataSize) {
        case '10x100':
            return 100;
        default:
            return 22;
    }
}

function getRowCount() {
    switch (dataSize) {
        case '.1x22':
            return 100;
        case '1x22':
            return 1000;
        case '10x100':
            return 10000;
        case '100x22':
            return 100000;
        default:
            return -1;
    }
}

function createCols() {
    var colCount = getColCount();
    // start with a copy of the default cols
    var columns = defaultCols.slice(0, colCount);

    // there are 22 cols by default
    for (var col = 22; col < colCount; col++) {
        var colName = colNames[col % colNames.length];
        var colDef = {headerName: colName, field: "col" + col, width: 200, editable: true};
        columns.push(colDef);
    }
    return columns;
}

var loadInstance = 0;

function createData() {

    var eMessage = document.querySelector('#message');
    var eMessageText = document.querySelector('#messageText');
    loadInstance++;

    var loadInstanceCopy = loadInstance;
    gridOptions.api.showLoadingOverlay();

    var colDefs = createCols();

    var rowCount = getRowCount();
    var colCount = getColCount();

    var row = 0;
    var data = [];

    eMessage.style.display = 'inline';

    var intervalId = setInterval(function () {
        if (loadInstanceCopy != loadInstance) {
            clearInterval(intervalId);
            return;
        }

        for (var i = 0; i < 1000; i++) {
            if (row < rowCount) {
                var rowItem = createRowItem(row, colCount);
                data.push(rowItem);
                row++;
            }
        }

        eMessageText.innerHTML = ' Generating rows ' + row;

        if (row >= rowCount) {
            clearInterval(intervalId);
            setTimeout(function () {
                gridOptions.api.setColumnDefs(colDefs);
                gridOptions.api.setRowData(data);
                eMessage.style.display = 'none';
                eMessageText.innerHTML = '';
            }, 0);
        }
    
    }, 0);
}

function createRowItem(row, colCount) {
    var rowItem = {};

    //create data for the known columns
    var countriesToPickFrom = Math.floor(countries.length * ((row % 3 + 1) / 3));
    var countryData = countries[(row*19) % countriesToPickFrom];
    rowItem.country = countryData.country;
    rowItem.continent = countryData.continent;
    rowItem.language = countryData.language;

    var firstName = firstNames[row % firstNames.length];
    var lastName = lastNames[row % lastNames.length];
    rowItem.name = firstName + " " + lastName;

    rowItem.game = {
        name: games[Math.floor(row*13/17*19) % games.length],
        bought: booleanValues[row % booleanValues.length]
    };

    rowItem.bankBalance = ((Math.round(pseudoRandom() * 10000000)) / 100) - 3000;
    rowItem.rating = (Math.round(pseudoRandom() * 5));

    var totalWinnings = 0;
    months.forEach(function (month) {
        var value = ((Math.round(pseudoRandom() * 10000000)) / 100) - 20;
        rowItem[month.toLocaleLowerCase()] = value;
        totalWinnings += value;
    });
    rowItem.totalWinnings = totalWinnings;

    //create dummy data for the additional columns
    for (var col = defaultCols.length; col < colCount; col++) {
        var value;
        var randomBit = pseudoRandom().toString().substring(2, 5);
        value = colNames[col % colNames.length] + "-" + randomBit + " - (" + (row + 1) + "," + col + ")";
        rowItem["col" + col] = value;
    }

    return rowItem;
}

// taken from http://stackoverflow.com/questions/3062746/special-simple-random-number-generator
var seed = 123456789;
var m = Math.pow(2, 32);
var a = 1103515245;
var c = 12345;
function pseudoRandom() {
    seed = (a * seed + c) % m;
    return seed / m;
}

function selectionChanged(event) {
    console.log('Callback selectionChanged: selection count = ' + gridOptions.api.getSelectedNodes().length);
}

function rowSelected(event) {
// the number of rows selected could be huge, if the user is grouping and selects a group, so
// to stop the console from clogging up, we only print if in the first 10 (by chance we know
// the node id's are assigned from 0 upwards)
    if (event.node.id < 10) {
        var valueToPrint = event.node.group ? 'group (' + event.node.key + ')' : event.node.data.name;
        console.log("Callback rowSelected: " + valueToPrint + " - " + event.node.isSelected());
    }
}


