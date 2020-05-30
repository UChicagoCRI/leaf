﻿// Copyright (c) 2020, UW Medicine Research IT, University of Washington
// Developed by Nic Dobbins and Cliff Spital, CRIO Sean Mooney
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.
using System;
using System.Collections.Generic;
using Model.Compiler;

namespace Model.Search
{
    public class ConceptTree
    {
        public IEnumerable<PanelFilter> PanelFilters { get; set; }
        public IEnumerable<Concept> Concepts { get; set; }
    }
}
