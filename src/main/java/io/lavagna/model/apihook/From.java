/**
 * This file is part of lavagna.
 *
 * lavagna is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * lavagna is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with lavagna.  If not, see <http://www.gnu.org/licenses/>.
 */

package io.lavagna.model.apihook;

import io.lavagna.model.BoardColumn;
import io.lavagna.model.CardFull;

public class From {

    public static Card from(CardFull cf) {
        return new Card(cf.getBoardShortName(), cf.getSequence(), cf.getProjectShortName());
    }


    public static User from(io.lavagna.model.User user) {
        return new User(user.getProvider(), user.getUsername(), user.getEmail(), user.getDisplayName());
    }

    public static Column from(BoardColumn column) {
        return new Column(column.getName(), column.getLocation().toString(), column.getStatus().toString(), column.getColor());
    }
}