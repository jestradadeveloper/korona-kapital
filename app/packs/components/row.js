import * as React from "react"
import Seat from "components/seat"


const Row = (props) => {
  const seatItems = Array.from(Array(props.seatsPerRow).keys()).map(
    (seatNumber) => {
      return <Seat key={seatNumber} seatNumber={seatNumber} />
    }
  )
  return <tr className="h-20">{seatItems}</tr>
}

export default Row
